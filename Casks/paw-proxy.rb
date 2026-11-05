cask "paw-proxy" do
  version "1.12.3"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.12.3/Paw-Proxy.app.zip"
  name "Paw Proxy"
  desc "Zero-config HTTPS proxy for local development"
  homepage "https://github.com/alexcatdad/paw-proxy"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Paw Proxy.app"
  binary "#{appdir}/Paw Proxy.app/Contents/Helpers/paw-proxy"
  binary "#{appdir}/Paw Proxy.app/Contents/Helpers/up"
  manpage "#{appdir}/Paw Proxy.app/Contents/Resources/man/paw-proxy.1"
  manpage "#{appdir}/Paw Proxy.app/Contents/Resources/man/up.1"

  uninstall quit: "com.alexcatdad.paw-proxy"

  zap trash: [
    "~/Library/Application Support/paw-proxy",
    "~/Library/Logs/paw-proxy.log",
  ]

  caveats <<~EOS
    Run once to trust the local CA, configure *.test DNS and start the proxy:
      sudo paw-proxy setup

    After an upgrade, restart the proxy so it runs the new version:
      paw-proxy restart

    Before uninstalling, remove the CA, DNS resolver and background item:
      sudo paw-proxy uninstall
  EOS
end
