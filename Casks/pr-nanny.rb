# frozen_string_literal: true

cask "pr-nanny" do
  version "2026.11.06.2"
  sha256 "d7f451951888477f51861df5335ca9bf75b53aee71ea9722fe155ae9387bd251"

  url "https://github.com/alexcatdad/pr-nanny/releases/download/v2026.11.06.2/pr-nanny-2026.11.06.2-darwin-arm64.zip"
  name "PR Nanny"
  desc "Passive GitHub pull-request monitor"
  homepage "https://github.com/alexcatdad/pr-nanny"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "PR Nanny.app"
end
