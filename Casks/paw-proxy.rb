cask "paw-proxy" do
  version "2026.11.06.1"
  sha256 "418a2eeb27c928ae50e8d8ae7d9e416c935fb1e6228e5658049ea97551412fc3"

  url "https://github.com/alexcatdad/paw-proxy/releases/download/v2026.11.06.1/Paw-Proxy.app.zip"
  name "Paw Proxy"
  desc "Zero-config HTTPS proxy for local development"
  homepage "https://github.com/alexcatdad/paw-proxy"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Paw Proxy.app"
  binary "#{appdir}/Paw Proxy.app/Contents/Helpers/paw-proxy"
  binary "#{appdir}/Paw Proxy.app/Contents/Helpers/up"

  zap trash: "~/Library/Application Support/paw-proxy"
end
