#!/bin/sh
set -eu

tag=${1:?usage: update-pr-nanny.sh vVERSION [--bootstrap-rc1]}
mode=${2:-}
case "$mode" in ''|--bootstrap-rc1) ;; *) echo 'Unknown update mode' >&2; exit 2;; esac
case "$tag" in v*) version=${tag#v} ;; *) echo 'Release tag must start with v' >&2; exit 2;; esac
numeric='(0|[1-9][0-9]*)'
prerelease_id="(0|[1-9][0-9]*|[0-9A-Za-z-]*[A-Za-z-][0-9A-Za-z-]*)"
build_id='[0-9A-Za-z-]+'
semver="^$numeric\\.$numeric\\.$numeric(-$prerelease_id(\\.$prerelease_id)*)?(\\+$build_id(\\.$build_id)*)?$"
printf '%s\n' "$version" | grep -Eq "$semver" || { echo 'Release tag must contain a valid SemVer version' >&2; exit 2; }
if [ "$mode" = --bootstrap-rc1 ] && [ "$tag" != v0.1.0-rc.1 ]; then
  echo 'The no-attestation bootstrap is limited to v0.1.0-rc.1' >&2
  exit 2
fi

command -v gh >/dev/null || { echo 'gh is required' >&2; exit 2; }
command -v jq >/dev/null || { echo 'jq is required' >&2; exit 2; }
command -v shasum >/dev/null || { echo 'shasum is required' >&2; exit 2; }
command -v ruby >/dev/null || { echo 'ruby is required' >&2; exit 2; }

root=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)
output=${PR_NANNY_OUTPUT_DIR:-$root}
mkdir -p "$output/Casks" "$output/Formula"
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT HUP INT TERM
repo=alexcatdad/pr-nanny
release=$(gh api "repos/$repo/releases/tags/$tag")
printf '%s' "$release" | jq -e --arg tag "$tag" '.tag_name == $tag and .draft == false' >/dev/null || {
  echo 'The source release is missing, draft, or has a different tag' >&2
  exit 1
}

gh release download "$tag" --repo "$repo" --dir "$work" \
  --pattern "pr-nanny-$version-darwin-arm64.zip" \
  --pattern "pr-nanny-$version-darwin-arm64.zip.sha256" \
  --pattern "pr-nanny-$version-linux-x64.tar.gz" \
  --pattern "pr-nanny-$version-linux-x64.tar.gz.sha256" \
  --pattern "pr-nanny-$version-windows-x64.zip" \
  --pattern "pr-nanny-$version-windows-x64.zip.sha256" \
  --pattern SHA256SUMS --pattern SOURCE.txt

for archive in \
  "pr-nanny-$version-darwin-arm64.zip" \
  "pr-nanny-$version-linux-x64.tar.gz" \
  "pr-nanny-$version-windows-x64.zip"; do
  [ -f "$work/$archive" ] || { echo "Missing required release archive: $archive" >&2; exit 1; }
  [ -f "$work/$archive.sha256" ] || { echo "Missing archive checksum: $archive.sha256" >&2; exit 1; }
  grep -Eq "^[[:xdigit:]]{64}  (\./)?$archive$" "$work/SHA256SUMS" || { echo "SHA256SUMS does not list $archive" >&2; exit 1; }
done
(cd "$work" && shasum -a 256 -c SHA256SUMS && for checksum in ./*.sha256; do shasum -a 256 -c "$checksum"; done)

[ "$(awk 'END { print NR }' "$work/SOURCE.txt")" -eq 1 ] || { echo 'SOURCE.txt must contain exactly one line' >&2; exit 1; }
source_sha=$(sed -nE 's#^Source: https://github\.com/alexcatdad/pr-nanny/commit/([0-9a-f]{40})$#\1#p' "$work/SOURCE.txt")
case "$source_sha" in *[!0-9a-f]*|'') echo 'Invalid source commit in SOURCE.txt' >&2; exit 1;; esac
[ "${#source_sha}" -eq 40 ] || { echo 'Invalid source commit in SOURCE.txt' >&2; exit 1; }
tag_sha=$(gh api "repos/$repo/commits/$tag" --jq '.sha')
[ "$tag_sha" = "$source_sha" ] || { echo 'Release tag does not point at SOURCE.txt commit' >&2; exit 1; }

if [ "$mode" = --bootstrap-rc1 ]; then
  [ "$source_sha" = 4697f8b025a3cc86615a126d7983997c460e7ce4 ] || {
    echo 'RC1 bootstrap source commit did not match its qualified release' >&2
    exit 1
  }
else
  for archive in \
    "pr-nanny-$version-darwin-arm64.zip" \
    "pr-nanny-$version-linux-x64.tar.gz" \
    "pr-nanny-$version-windows-x64.zip"; do
    gh attestation verify "$work/$archive" --repo "$repo" \
      --source-digest "$source_sha" \
      --signer-workflow alexcatdad/pr-nanny/.github/workflows/ci.yml
  done
fi

mac_archive="pr-nanny-$version-darwin-arm64.zip"
linux_archive="pr-nanny-$version-linux-x64.tar.gz"
mac_sha=$(shasum -a 256 "$work/$mac_archive" | cut -d ' ' -f1)
linux_sha=$(shasum -a 256 "$work/$linux_archive" | cut -d ' ' -f1)
base="https://github.com/$repo/releases/download/$tag"

cat > "$output/Casks/pr-nanny.rb" <<EOF
cask "pr-nanny" do
  version "$version"
  sha256 "$mac_sha"

  url "$base/$mac_archive"
  name "PR Nanny"
  desc "Passive GitHub pull-request monitor"
  homepage "https://github.com/$repo"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "PR Nanny.app"

  caveats <<~EOS
    This build is ad-hoc signed and not notarized.
    macOS may show a security prompt when you first open it.
  EOS
end
EOF

cat > "$output/Formula/pr-nanny.rb" <<EOF
class PrNanny < Formula
  desc "Passive GitHub pull-request monitor"
  homepage "https://github.com/$repo"
  url "$base/$linux_archive"
  version "$version"
  sha256 "$linux_sha"
  license "MIT"

  depends_on :linux

  def install
    odie "PR Nanny Linux packages require x86_64" unless Hardware::CPU.intel?
    bin.install "bin/pr-nanny"
    (share/"applications").install "share/applications/pr-nanny.desktop"
    (share/"icons/hicolor/256x256/apps").install "share/icons/hicolor/256x256/apps/pr-nanny.png"
    pkgshare.install "scripts/apparmor-profile.sh", "APPARMOR.md"
  end

  def caveats
    <<~EOS
      Requires GTK4, WebKitGTK 6.0, a Secret Service provider and glibc 2.39 or newer.
      The Linux archive is built on Ubuntu 24.04.
    EOS
  end

  test do
    assert_predicate bin/"pr-nanny", :executable?
  end
end
EOF

APP_VERSION=$version README_PATH="$output/README.md" ruby <<'RUBY'
path = ENV.fetch("README_PATH")
version = ENV.fetch("APP_VERSION")
text = File.read(path)
row = "| [pr-nanny](https://github.com/alexcatdad/pr-nanny) | #{version} | Passive GitHub pull-request monitor (macOS ARM64 cask, Linux x64 formula) |"
if text.match?(/^\| \[pr-nanny\].*$/)
  text.sub!(/^\| \[pr-nanny\].*$/, row)
else
  anchor = text.match(/^\| \[paw\].*$/)
  raise "Could not find the package table insertion point in #{path}" unless anchor
  text.sub!(anchor[0], "#{anchor[0]}\n#{row}")
end
File.write(path, text)
RUBY

printf 'Prepared PR Nanny %s manifests from source %s\n' "$version" "$source_sha"
