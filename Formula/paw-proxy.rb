class PawProxy < Formula
  desc "Zero-config HTTPS proxy for local macOS development"
  homepage "https://github.com/alexcatdad/paw-proxy"
  license "MIT"
  version "1.3.0"

  on_macos do
    on_arm do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.3.0/paw-proxy-darwin-arm64"
      sha256 "7587e6c0e5dd93dc03de855fe8518b73a75bf92ce11b3a3335efac937f070bb0"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.3.0/up-darwin-arm64"
        sha256 "19c9f1040e0c718f3dbb456c60182daf6592088803d68e8fa1178560f26bd9b1"
      end
    end

    on_intel do
      url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.3.0/paw-proxy-darwin-amd64"
      sha256 "e65c5c04d9061fb238f451a74003c65b5f01952476fa5df59cdc827ee5b21371"

      resource "up" do
        url "https://github.com/alexcatdad/paw-proxy/releases/download/v1.3.0/up-darwin-amd64"
        sha256 "725ab5bc9457ba068c43ab03a9cb2c2ae10102866c275cf1dfcc6da4eaff2b90"
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
