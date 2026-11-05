cask "paw-proxy" do
  version "0.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/example-org/paw-proxy/releases/download/v0.0.0/Paw-Proxy.app.zip"
  name "Paw Proxy"
  desc "Zero-config HTTPS proxy for local development"
  homepage "https://github.com/example-org/paw-proxy"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Paw Proxy.app"

  zap trash: "~/Library/Application Support/paw-proxy"
end
