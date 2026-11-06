# frozen_string_literal: true

cask "pr-nanny" do
  version "2026.11.05.1"
  sha256 "09e3af5c80c162ef1ef2e20f0d74bdf03150950ad75189229583ad8fe38516ae"

  url "https://github.com/alexcatdad/pr-nanny/releases/download/v2026.11.05.1/pr-nanny-2026.11.05.1-darwin-arm64.zip"
  name "PR Nanny"
  desc "Passive GitHub pull-request monitor"
  homepage "https://github.com/alexcatdad/pr-nanny"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "PR Nanny.app"
end
