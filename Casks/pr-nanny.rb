# frozen_string_literal: true

cask "pr-nanny" do
  version "0.1.0-rc.6"
  sha256 "cba3756f89c1bb9cbda04bcbd8e4b63f8efb273577a66951ce8249c31944a5e6"

  url "https://github.com/alexcatdad/pr-nanny/releases/download/v0.1.0-rc.6/pr-nanny-0.1.0-rc.6-darwin-arm64.zip"
  name "PR Nanny"
  desc "Passive GitHub pull-request monitor"
  homepage "https://github.com/alexcatdad/pr-nanny"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "PR Nanny.app"
end
