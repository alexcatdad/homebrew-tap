# frozen_string_literal: true

cask "pr-nanny" do
  version "2026.11.07.1"
  sha256 "60bab5710298f8c1c2567c678b6a5a7f3e83053b33ad3a3ec6e7eb02395e086c"

  url "https://github.com/alexcatdad/pr-nanny/releases/download/v2026.11.07.1/pr-nanny-2026.11.07.1-darwin-arm64.zip"
  name "PR Nanny"
  desc "Passive GitHub pull-request monitor"
  homepage "https://github.com/alexcatdad/pr-nanny"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "PR Nanny.app"
end
