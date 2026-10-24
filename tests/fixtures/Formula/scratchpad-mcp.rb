class ScratchpadMcp < Formula
  desc "Private project memory for developers and coding agents"
  homepage "https://github.com/example-org/scratchpad"
  version "0.3.0"

  depends_on "git"
  depends_on "openssh"

  on_macos do
    on_arm do
        url "https://github.com/example-org/scratchpad/releases/download/v0.3.0/scratchpad-mcp-v0.3.0-darwin-arm64.zip"
        sha256 "0000000000000000000000000000000000000000000000000000000000000001"
    end
    on_intel do
        url "https://github.com/example-org/scratchpad/releases/download/v0.3.0/scratchpad-mcp-v0.3.0-darwin-amd64.zip"
        sha256 "0000000000000000000000000000000000000000000000000000000000000002"
    end
  end

  on_linux do
    on_arm do
        url "https://github.com/example-org/scratchpad/releases/download/v0.3.0/scratchpad-mcp-v0.3.0-linux-arm64.tar.gz"
        sha256 "0000000000000000000000000000000000000000000000000000000000000003"
    end
    on_intel do
        url "https://github.com/example-org/scratchpad/releases/download/v0.3.0/scratchpad-mcp-v0.3.0-linux-amd64.tar.gz"
        sha256 "0000000000000000000000000000000000000000000000000000000000000004"
    end
  end

  def install
    bin.install "scratchpad-mcp"
  end

  test do
    assert_equal "scratchpad-mcp #{version}", shell_output("#{bin}/scratchpad-mcp --version").strip
  end
end
