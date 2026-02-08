class PawProxy < Formula
  desc "Zero-config HTTPS proxy for local macOS development"
  homepage "https://github.com/alexcatdad/paw-proxy"
  license "MIT"
  version "1.2.0"

  on_macos do
    on_arm do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v#{version}/paw-proxy-darwin-arm64"
      sha256 "cb4e422c24371803fbae652981325580b6694f0d71336b3c022fcd8d4205d804"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v#{version}/up-darwin-arm64"
        sha256 "af09ca2479c0771b7078e31e8b6675f5dec05f3118ec244787dde59dc92b1364"
      end
    end

    on_intel do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v#{version}/paw-proxy-darwin-amd64"
      sha256 "ba0869765d24641a2ce465a8fa9365f8e243ea4278f76d8ee6e1e06b585998a2"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v#{version}/up-darwin-amd64"
        sha256 "25c93d1506b54161ce5be03e00b17f9ff16f0383a76315ce10cf2920d930de0b"
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
