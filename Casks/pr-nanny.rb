# frozen_string_literal: true

cask "pr-nanny" do
  version "2026.11.06.1"
  sha256 "ab5e0e6a2267070c41395be25ac5e85e9e852cc8d360b1e45cb3491421667197"

  url "https://github.com/alexcatdad/pr-nanny/releases/download/v2026.11.06.1/pr-nanny-2026.11.06.1-darwin-arm64.zip"
  name "PR Nanny"
  desc "Passive GitHub pull-request monitor"
  homepage "https://github.com/alexcatdad/pr-nanny"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "PR Nanny.app"
end
