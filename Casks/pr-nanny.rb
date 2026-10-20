cask "pr-nanny" do
  version "0.1.0-rc.1"
  sha256 "39781b9efecb2aeb0b00f7e2bafb3d01cdce7e764b49e3c7e8d6842ec81bedfd"

  url "https://github.com/alexcatdad/pr-nanny/releases/download/v0.1.0-rc.1/pr-nanny-0.1.0-rc.1-darwin-arm64.zip"
  name "PR Nanny"
  desc "Passive GitHub pull-request monitor"
  homepage "https://github.com/alexcatdad/pr-nanny"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "PR Nanny.app"

  caveats <<~EOS
    This prerelease is ad-hoc signed and not notarized.
    macOS may show a security prompt when you first open it.
  EOS
end
