class PawProxy < Formula
  desc "Zero-config HTTPS proxy for local macOS development"
  homepage "https://github.com/alexcatdad/paw-proxy"
  license "MIT"
  version "1.12.1"

  on_macos do
    on_arm do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.12.1/paw-proxy-darwin-arm64"
      sha256 "1240f4b002bfaf8b184b6d42dcbf2495f05244a7a29b773f4686f30f3823cf5d"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.12.1/up-darwin-arm64"
        sha256 "f0f2b298be14e36a0df30785ef23cf4bcaf60f8322f8fdda75dbcf116f90d737"
      end
    end

    on_intel do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.12.1/paw-proxy-darwin-amd64"
      sha256 "8ca22104e2660f64e1838b9714a99cf9c093cf1f666219379794c50790be7204"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.12.1/up-darwin-amd64"
        sha256 "b8eb1d7522bfe37ff2b885f0a5f645d1303ed89e6e05ea78607a94a99359f09c"
      end
    end
  end

  resource "man-pages" do
    url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.12.1/man-pages.tar.gz"
    sha256 "541d5bf1669a83de522f03f6b040787fc170625005b08880a4fb21ffe727ffb0"
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
