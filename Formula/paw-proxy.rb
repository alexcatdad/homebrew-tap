class PawProxy < Formula
  desc "Zero-config HTTPS proxy for local macOS development"
  homepage "https://github.com/alexcatdad/paw-proxy"
  license "MIT"
  version "1.2.3"

  on_macos do
    on_arm do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.2.3/paw-proxy-darwin-arm64"
      sha256 "3bfd29bd1b0af517e2ddf5a200328810ebd83e708ef0fa4b67cb33b9b71ec944"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.2.3/up-darwin-arm64"
        sha256 "89f1826c84b1f788facdb3d8e2b194275a6147ce701e53be1ff6333445146946"
      end
    end

    on_intel do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.2.3/paw-proxy-darwin-amd64"
      sha256 "a04b8b76a480f2d477ca49667f12e2b9299ffad28025dc678fca698524eee71d"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.2.3/up-darwin-amd64"
        sha256 "1ccba38260eb54cac64d022a8550fd043c7fa8523d92adb88452f0a19d335d0a"
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
