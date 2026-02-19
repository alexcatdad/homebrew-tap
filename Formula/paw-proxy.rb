class PawProxy < Formula
  desc "Zero-config HTTPS proxy for local macOS development"
  homepage "https://github.com/alexcatdad/paw-proxy"
  license "MIT"
  version "1.6.0"

  on_macos do
    on_arm do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.6.0/paw-proxy-darwin-arm64"
      sha256 "8a80b9f59e820b12f417aa6e34cbace17f0f1997cbcafee506d8c55608c14dbb"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.6.0/up-darwin-arm64"
        sha256 "5549a57746c6452d6dbbc741abb3184c51adf59ab3b9dbcf969460969f624912"
      end
    end

    on_intel do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.6.0/paw-proxy-darwin-amd64"
      sha256 "2336aea2dc7ca4b7579ac6415344a09d095760091bb3491f51be6752250dcfc9"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.6.0/up-darwin-amd64"
        sha256 "30812160848a2af41b568665fd814861b7fbf7e91bcfda3640aa62fa9c7deb42"
      end
    end
  end

  resource "man-pages" do
    url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.6.0/man-pages.tar.gz"
    sha256 "5d3326777ff0812a59d88249a50184488fb0faa414affe12c426de2bad8046be"
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
