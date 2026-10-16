class PawProxy < Formula
  desc "Zero-config HTTPS proxy for local macOS development"
  homepage "https://github.com/alexcatdad/paw-proxy"
  license "MIT"
  version "1.12.3"

  on_macos do
    on_arm do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.12.3/paw-proxy-darwin-arm64"
      sha256 "7a3debc2512eed465570df44145f07098b446b727198e860e09907a1f1c427bf"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.12.3/up-darwin-arm64"
        sha256 "e5a0a34360438cf528417169bf5cce401bae4ee3da1034a2cbf8163ea3138c5f"
      end
    end

    on_intel do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.12.3/paw-proxy-darwin-amd64"
      sha256 "7c71cd2d080556bf9b2e3efffe109bed11b42ef0f325ff69f5a0f14f09e706fb"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.12.3/up-darwin-amd64"
        sha256 "897a30d30aa3d7f5d08bae1c23f4ca668ef07cda1c2b8aa3fb15ca26e67b0fec"
      end
    end
  end

  resource "man-pages" do
    url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.12.3/man-pages.tar.gz"
    sha256 "8ee9de2ee7051d5fa365a3a258e9c66ad33bfe8ff5534abcd68cee292c81ea24"
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
