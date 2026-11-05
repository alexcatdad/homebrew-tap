cask "scratchpad" do
  # From 2026-11-05 Scratchpad releases are published only on the owner's
  # Forgejo (forgejo.triceratops-dory.ts.net), so after the first Forgejo
  # release this cask installs only on the owner's tailnet.
  version "2026.10.3"
  sha256 "ee3e412e32e000c955d031e5a03fa1613e11089088a9742f0a5cafd6a2fb6047"

  url "https://github.com/alexcatdad/scratchpad/releases/download/v2026.10.3/scratchpad-2026.10.3-darwin-arm64.zip"
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
