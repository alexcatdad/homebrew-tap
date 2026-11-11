cask "scratchpad" do
  version "2026.11.11.1"
  sha256 "fcf4ce66d3df64f077e06a0d23aed71cdbde64c431e668a8102ca9cab2db0b07"

  url "https://github.com/alexcatdad/scratchpad/releases/download/v2026.11.11.1/scratchpad-2026.11.11.1-darwin-arm64.zip"
  name "Scratchpad"
  desc "Menu bar app for private developer memory"
  homepage "https://github.com/alexcatdad/scratchpad"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Scratchpad.app"

  uninstall quit: "com.alexcatdad.scratchpad"

  caveats <<~EOS
    After an upgrade, choose Stop service and then Start service from the
    Scratchpad menu-bar icon so the capture service runs the new version.
    It also switches automatically at your next login.
  EOS
end
