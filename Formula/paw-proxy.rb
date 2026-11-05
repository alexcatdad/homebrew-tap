class PawProxy < Formula
  desc "Zero-config HTTPS proxy for local development (Linux; macOS uses the cask)"
  homepage "https://github.com/alexcatdad/paw-proxy"
  version "1.12.3"
  license "MIT"

  # macOS installs Paw Proxy.app instead:
  #   brew uninstall paw-proxy && brew install --cask alexcatdad/tap/paw-proxy
  depends_on :linux

  on_linux do
    on_arm do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.12.3/paw-proxy-linux-arm64"
      sha256 "e41f3bfb09173b2902d49c628a5c501624aacadeb51b58322c1bf965c8250b33"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.12.3/up-linux-arm64"
        sha256 "870f38c87e2f9f54c605206dbf924964ea5f84923032e392e04ded8563e71747"
      end
    end

    on_intel do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.12.3/paw-proxy-linux-amd64"
      sha256 "9bd1cd1b883e51967ab707d62df02807ec57edcb34f3aeb21a99cf4c6fe87158"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.12.3/up-linux-amd64"
        sha256 "1c5a485efb59439121e56a38497d6cff64d8032a2a9c97186ae41149939492d7"
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

  def caveats
    "Run 'sudo paw-proxy setup' to configure the CA, DNS resolver and user service."
  end

  test do
    assert_match "paw-proxy", shell_output("#{bin}/paw-proxy version")
  end
end
