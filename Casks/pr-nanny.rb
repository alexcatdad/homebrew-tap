cask "pr-nanny" do
  version "0.1.0-rc.4"
  sha256 "14fe9cf9eeff4fa6447e1ccfe71c388d4f588d7d9372fc742b8bf74a8f83297e"

  url "https://github.com/alexcatdad/pr-nanny/releases/download/v0.1.0-rc.4/pr-nanny-0.1.0-rc.4-darwin-arm64.zip"
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
