cask "paw-proxy" do
  version "2026.11.06.2"
  sha256 "8a138ff7112b16bcc3926c3c01a8df958d578e1ccf50546184d8e76ff76763a2"

  url "https://github.com/alexcatdad/paw-proxy/releases/download/v2026.11.06.2/Paw-Proxy.app.zip"
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
