class PawProxy < Formula
  desc "Zero-config HTTPS proxy for local macOS development"
  homepage "https://github.com/alexcatdad/paw-proxy"
  license "MIT"
  version "1.9.0"

  on_macos do
    on_arm do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.9.0/paw-proxy-darwin-arm64"
      sha256 "3322da65c57c5616a6ebcf88c74e110267223dbef93713fa3bcbca7ba655c39b"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.9.0/up-darwin-arm64"
        sha256 "0d91813d052f5db50f8caa0e67c0797aeb67ec64983f4fc291bf1022c092950e"
      end
    end

    on_intel do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.9.0/paw-proxy-darwin-amd64"
      sha256 "23ce78e5413a1ea57e543678a57a9475aad52aee8e7c257b9770fd572a9e7fa0"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.9.0/up-darwin-amd64"
        sha256 "9750a2841ff4be1a5c8f4cbd85d0ebdc66862465b387ffe0eb000e346f3fe54c"
      end
    end
  end

  resource "man-pages" do
    url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.9.0/man-pages.tar.gz"
    sha256 "00b91b87370101fb43eb722dcaeaf8fff1003dd5f18a78ab147adbd3cb3721b0"
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
