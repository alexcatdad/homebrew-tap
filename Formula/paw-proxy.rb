class PawProxy < Formula
  desc "Zero-config HTTPS proxy for local macOS development"
  homepage "https://github.com/alexcatdad/paw-proxy"
  license "MIT"
  version "1.4.0"

  on_macos do
    on_arm do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.4.0/paw-proxy-darwin-arm64"
      sha256 "b51ba83d5e159501b60a42ff5d95dfc0cee0292e532365dff48e0ee3b2713917"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.4.0/up-darwin-arm64"
        sha256 "23699bf91f74d351802d823d523af5194292b4da502271527b8f10f6aaef9e91"
      end
    end

    on_intel do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.4.0/paw-proxy-darwin-amd64"
      sha256 "e22ba001c99f5fc8261d19881f2147afa15b7148bc39b115360014f3b276cd4b"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.4.0/up-darwin-amd64"
        sha256 "d691caf35bfbbfe5ecf217173df6d4b135c1152affac622031284093549503e7"
      end
    end
  end

  resource "man-pages" do
    url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.4.0/man-pages.tar.gz"
    sha256 "2e013922275f76ccccd95e809b5af6735c42922ce0bf40dbc2dafda67c0ce072"
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
