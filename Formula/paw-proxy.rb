class PawProxy < Formula
  desc "Zero-config HTTPS proxy for local macOS development"
  homepage "https://github.com/alexcatdad/paw-proxy"
  license "MIT"
  version "1.8.0"

  on_macos do
    on_arm do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.8.0/paw-proxy-darwin-arm64"
      sha256 "ecfa3b6eec9275d7648790637af12d5475474c0d5c75c3e47683c7861771d32e"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.8.0/up-darwin-arm64"
        sha256 "448bb1927a3afa91a4a12a51240d82a489256fc7533931c9a9a766573a053352"
      end
    end

    on_intel do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.8.0/paw-proxy-darwin-amd64"
      sha256 "c195269f930677a022b42b948c78234c249aa4c11ada6645817dee3a6edd2aac"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.8.0/up-darwin-amd64"
        sha256 "0833c64cee0eccf6cac833ca662e3664646dec1ccb42779bcd1880a38359a587"
      end
    end
  end

  resource "man-pages" do
    url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.8.0/man-pages.tar.gz"
    sha256 "410bbc41b7feb5ce053d69223932d9ce356723b8b7b86755fc7dc054f297708d"
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
