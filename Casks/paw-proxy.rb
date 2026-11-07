cask "paw-proxy" do
  version "2026.11.07.1"
  sha256 "d8db5b2e1ad67f4a103eecb0eb93218fd995c42e6163d49d80305a796e9f2576"

  url "https://github.com/alexcatdad/paw-proxy/releases/download/v2026.11.07.1/Paw-Proxy.app.zip"
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
