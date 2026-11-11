cask "paw-proxy" do
  version "2026.11.11.2"
  sha256 "f034af3fa3050b6d4ddf2534a68ca1e471f9d210ff2f4f0aa11d1b45c2be0615"

  url "https://github.com/alexcatdad/paw-proxy/releases/download/v2026.11.11.2/Paw-Proxy.app.zip"
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
