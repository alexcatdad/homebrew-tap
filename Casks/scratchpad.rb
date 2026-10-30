cask "scratchpad" do
  version "2026.10.2"
  sha256 "25bb62ee0e05494f627b8e067a15c6423bdec9f2c937e7788e0c8a47df2a185e"

  url "https://github.com/alexcatdad/scratchpad/releases/download/v2026.10.2/scratchpad-2026.10.2-darwin-arm64.zip"
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
