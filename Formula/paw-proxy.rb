class PawProxy < Formula
  desc "Zero-config HTTPS proxy for local macOS development"
  homepage "https://github.com/alexcatdad/paw-proxy"
  license "MIT"
  version "1.3.1"

  on_macos do
    on_arm do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.3.1/paw-proxy-darwin-arm64"
      sha256 "f1ad0a28905592ddbdfa5ea9268aca9c75cd5186405606bfe23b55e7365ecd8f"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.3.1/up-darwin-arm64"
        sha256 "a26d223ebe036fd2855c0f1301a20919c947ea4ade0ea58a782d265f23bd0faa"
      end
    end

    on_intel do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.3.1/paw-proxy-darwin-amd64"
      sha256 "28361edb95176a920825c51e0be7c4eed326140ced4bad30490fefa3b1c9f8db"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.3.1/up-darwin-amd64"
        sha256 "d919d0d65edc630e0142c760ec5d383c1fedfa8ba7c744ce60767fd6d5458ff6"
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
