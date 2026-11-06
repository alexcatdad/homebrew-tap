cask "scratchpad" do
  # Scratchpad releases are published only on the owner's Forgejo
  # (forgejo.triceratops-dory.ts.net), which requires sign-in, so this cask
  # installs only on the owner's tailnet and needs HOMEBREW_FORGEJO_TOKEN: a
  # read-only token of the scratchpad-releases account, loaded through
  # brew.env. Without it Forgejo returns its sign-in page and the checksum fails.
  version "2026.11.06.3"
  sha256 "7761640671ee156bd3cbba626a26ebf413621bb73e258ac6ec98848f9b06b6e3"

  url "https://forgejo.triceratops-dory.ts.net/alexcatdad/scratchpad/releases/download/v2026.11.06.3/scratchpad-2026.11.06.3-darwin-arm64.zip",
      header: "Authorization: token #{ENV.fetch("HOMEBREW_FORGEJO_TOKEN", "")}"
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
