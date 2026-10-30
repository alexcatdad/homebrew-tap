cask "scratchpad" do
  version "1.0.2"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/example-org/scratchpad/releases/download/v1.0.2/scratchpad-1.0.2-darwin-arm64.zip"
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
