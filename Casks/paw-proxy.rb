cask "paw-proxy" do
  version "2026.11.06.3"
  sha256 "84549fd55431bd56c8af35c227126c4dc2555757078f7627fa6f1aeeab92451e"

  url "https://github.com/alexcatdad/paw-proxy/releases/download/v2026.11.06.3/Paw-Proxy.app.zip"
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
