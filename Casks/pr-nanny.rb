cask "pr-nanny" do
  version "0.1.0-rc.2"
  sha256 "5f2f284c98a212181b59ab3e0d4c3bd3ecf3837551b3b17612075056389b6ee1"

  url "https://github.com/alexcatdad/pr-nanny/releases/download/v0.1.0-rc.2/pr-nanny-0.1.0-rc.2-darwin-arm64.zip"
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
