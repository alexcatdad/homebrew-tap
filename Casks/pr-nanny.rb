cask "pr-nanny" do
  version "0.1.0-rc.3"
  sha256 "09c7c7adb928b6102aaec5e37fb7d328b030a5154ceca2eb3d067e12521094f4"

  url "https://github.com/alexcatdad/pr-nanny/releases/download/v0.1.0-rc.3/pr-nanny-0.1.0-rc.3-darwin-arm64.zip"
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
