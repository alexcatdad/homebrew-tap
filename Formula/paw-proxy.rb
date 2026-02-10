class PawProxy < Formula
  desc "Zero-config HTTPS proxy for local macOS development"
  homepage "https://github.com/alexcatdad/paw-proxy"
  license "MIT"
  version "1.2.1"

  on_macos do
    on_arm do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.2.1/paw-proxy-darwin-arm64"
      sha256 "2ef9a905a22c9be018954739869fa19f6538487f37d0fa7c974a7c6b8f740e4a"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.2.1/up-darwin-arm64"
        sha256 "67e0a92787548937e1f1c69150da81b0fb029146ad73822d55a433c61af7bb80"
      end
    end

    on_intel do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.2.1/paw-proxy-darwin-amd64"
      sha256 "4763a84bbc9652c0420219af365e1be20c6de01b1d58bfd3ef594949bdf7e7fd"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.2.1/up-darwin-amd64"
        sha256 "ca9b4bf68094020e8da403e952a94c78e8f4e405ce4bcefead993184178e7d3d"
      end
    end
  end

  def install
    bin.install Dir["paw-proxy-*"].first || "paw-proxy" => "paw-proxy"
    resource("up").stage do
      bin.install Dir["up-*"].first || "up" => "up"
    end
  end

  def post_install
    ohai "Run 'sudo paw-proxy setup' to configure CA, DNS resolver, and LaunchAgent"
  end

  test do
    assert_match "paw-proxy", shell_output("#{bin}/paw-proxy version")
  end
end
