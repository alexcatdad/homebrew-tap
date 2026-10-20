cask "pr-nanny" do
  version "0.1.0-rc.5"
  sha256 "0129abe4b4a03d74f87abb834c4dfea201bccf1e09cb3873143336d8af8a4c2f"

  url "https://github.com/alexcatdad/pr-nanny/releases/download/v0.1.0-rc.5/pr-nanny-0.1.0-rc.5-darwin-arm64.zip"
  name "PR Nanny"
  desc "Passive GitHub pull-request monitor"
  homepage "https://github.com/alexcatdad/pr-nanny"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "PR Nanny.app"

  caveats <<~EOS
    This build is ad-hoc signed and not notarized.
    macOS may show a security prompt when you first open it.
  EOS
end
