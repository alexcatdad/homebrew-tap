class PawProxy < Formula
  desc "Zero-config HTTPS proxy for local macOS development"
  homepage "https://github.com/alexcatdad/paw-proxy"
  license "MIT"
  version "1.5.0"

  on_macos do
    on_arm do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.5.0/paw-proxy-darwin-arm64"
      sha256 "3e966f1edc6604f8e1488b7827b2afffa91548c5b811dcb7d83ee27830165d30"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.5.0/up-darwin-arm64"
        sha256 "86df1a4a3a8cceed47f0268f3197a7d4b680afbe639ee760b2cff916be7fee0b"
      end
    end

    on_intel do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.5.0/paw-proxy-darwin-amd64"
      sha256 "24dee94680182b0cfb7eb9ba741cafca9b38de8423d82c74ce563fc562f36006"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.5.0/up-darwin-amd64"
        sha256 "2920c852acdf72cd3acd5875a07bf5d4a00cf040d67d5812c02569af833403b9"
      end
    end
  end

  resource "man-pages" do
    url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.5.0/man-pages.tar.gz"
    sha256 "f8f195d1c214431870f0a6ea6afe11cee614c61ce728e9439814f19b2e97ffa6"
  end

  def install
    bin.install Dir["paw-proxy-*"].first || "paw-proxy" => "paw-proxy"
    resource("up").stage do
      bin.install Dir["up-*"].first || "up" => "up"
    end
    resource("man-pages").stage do
      man1.install "paw-proxy.1"
      man1.install "up.1"
    end
  end

  def post_install
    ohai "Run 'sudo paw-proxy setup' to configure CA, DNS resolver, and LaunchAgent"
  end

  test do
    assert_match "paw-proxy", shell_output("#{bin}/paw-proxy version")
  end
end
