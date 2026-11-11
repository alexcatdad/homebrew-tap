cask "paw-proxy" do
  version "2026.11.11.1"
  sha256 "bfa4ee449b107f580a5d91ee896d60937b2ea8655ae21b97bc9d21a9cd1711e8"

  url "https://github.com/alexcatdad/paw-proxy/releases/download/v2026.11.11.1/Paw-Proxy.app.zip"
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
