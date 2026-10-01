class ScratchpadMcp < Formula
  desc "Private project memory for developers and coding agents"
  homepage "https://github.com/alexcatdad/scratchpad"
  version "0.1.2"

  depends_on "git"
  depends_on "openssh"

  on_macos do
    on_arm do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v0.1.2/scratchpad-mcp-v0.1.2-darwin-arm64.zip"
        sha256 "9ec9fb1c6a4df9cf3776059155d4af4abc7d336df98b0a31228295968828d245"
    end
    on_intel do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v0.1.2/scratchpad-mcp-v0.1.2-darwin-amd64.zip"
        sha256 "dae2aece67ae03fc4703e72a09993c6c044ba937edb3bf6aef6590f055982c35"
    end
  end

  on_linux do
    on_arm do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v0.1.2/scratchpad-mcp-v0.1.2-linux-arm64.tar.gz"
        sha256 "360280ccd0dedb9a45276c325bd3c3b8fa37d4b49d0f1188c01665380477d36f"
    end
    on_intel do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v0.1.2/scratchpad-mcp-v0.1.2-linux-amd64.tar.gz"
        sha256 "9cbe02e7c6dbe65042efe4956761f3ed93308e16a9270ed6835927c3db3a0611"
    end
  end

  def install
    bin.install "scratchpad-mcp"
  end

  test do
    assert_equal "scratchpad-mcp #{version}", shell_output("#{bin}/scratchpad-mcp --version").strip
  end
end
