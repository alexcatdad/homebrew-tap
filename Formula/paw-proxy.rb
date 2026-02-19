class PawProxy < Formula
  desc "Zero-config HTTPS proxy for local macOS development"
  homepage "https://github.com/alexcatdad/paw-proxy"
  license "MIT"
  version "1.7.0"

  on_macos do
    on_arm do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.7.0/paw-proxy-darwin-arm64"
      sha256 "885e055039bec8638fd61acddd0d04a25706b35181d3f8f83ab284b2521cce7d"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.7.0/up-darwin-arm64"
        sha256 "8b333c9c12f385d196da4cb233961af8a3e7b84ec63493500926302a6dde5f8f"
      end
    end

    on_intel do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.7.0/paw-proxy-darwin-amd64"
      sha256 "e485f855be2e213b7fcc8e27b43851427c25c8669e5d86254730042a381c82ab"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.7.0/up-darwin-amd64"
        sha256 "e44e242584ce92f5d74e2c01e2a9ca2bf3f218b1fc5240ac008c48c3c307bf02"
      end
    end
  end

  resource "man-pages" do
    url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.7.0/man-pages.tar.gz"
    sha256 "b12c960a277a40aa0391bf34806da556d3deda49fb9509a209eb9c80a963d7a1"
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
