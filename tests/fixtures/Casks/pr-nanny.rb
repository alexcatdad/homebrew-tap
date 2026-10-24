# frozen_string_literal: true

cask "pr-nanny" do
  version "0.1.0-rc.6"
  sha256 "0000000000000000000000000000000000000000000000000000000000000001"

  url "https://github.com/example-org/pr-nanny/releases/download/v0.1.0-rc.6/pr-nanny-0.1.0-rc.6-darwin-arm64.zip"
  name "PR Nanny"
  desc "Passive GitHub pull-request monitor"
  homepage "https://github.com/example-org/pr-nanny"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "PR Nanny.app"
end
