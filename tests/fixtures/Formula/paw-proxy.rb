class PawProxy < Formula
  desc "Zero-config HTTPS proxy for local macOS development"
  homepage "https://github.com/example-org/paw-proxy"
  license "MIT"
  version "1.12.3"

  on_macos do
    on_arm do
      url "https://github.com/example-org/paw-proxy/releases/download/v1.12.3/paw-proxy-darwin-arm64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000001"

      resource "up" do
        url "https://github.com/example-org/paw-proxy/releases/download/v1.12.3/up-darwin-arm64"
        sha256 "0000000000000000000000000000000000000000000000000000000000000002"
      end
    end

    on_intel do
      url "https://github.com/example-org/paw-proxy/releases/download/v1.12.3/paw-proxy-darwin-amd64"
      sha256 "0000000000000000000000000000000000000000000000000000000000000003"

      resource "up" do
        url "https://github.com/example-org/paw-proxy/releases/download/v1.12.3/up-darwin-amd64"
        sha256 "0000000000000000000000000000000000000000000000000000000000000004"
      end
    end
  end

  resource "man-pages" do
    url "https://github.com/example-org/paw-proxy/releases/download/v1.12.3/man-pages.tar.gz"
    sha256 "0000000000000000000000000000000000000000000000000000000000000005"
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
