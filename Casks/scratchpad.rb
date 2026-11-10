cask "scratchpad" do
  version "2026.11.07.1"
  sha256 "f601ff06fc79b0f22630ebf7dff3ba24492a2be6be9a20467b487ded57dc8385"

  url "https://forgejo.triceratops-dory.ts.net/alexcatdad/scratchpad/releases/download/v2026.11.07.1/scratchpad-2026.11.07.1-darwin-arm64.zip"
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
