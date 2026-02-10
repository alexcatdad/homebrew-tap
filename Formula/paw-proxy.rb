class PawProxy < Formula
  desc "Zero-config HTTPS proxy for local macOS development"
  homepage "https://github.com/alexcatdad/paw-proxy"
  license "MIT"
  version "1.2.2"

  on_macos do
    on_arm do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.2.2/paw-proxy-darwin-arm64"
      sha256 "2c62a23f0793487f3b307ef4a9c2d889c9ad4f553f19aa07d1f41132f6374101"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.2.2/up-darwin-arm64"
        sha256 "852334a39d0250cb75ef4fabddf4df1b25f9461701d3ccf92ddb84666006ad28"
      end
    end

    on_intel do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.2.2/paw-proxy-darwin-amd64"
      sha256 "b0a300bc3e9ffe3e4ee7ec122318c1bde96b076104c9b69cf35c8ca5a1e8cda2"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.2.2/up-darwin-amd64"
        sha256 "302799e43e736a5d036384136dfa8e2641fb5ab71f934bc5537ba4befe110462"
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
