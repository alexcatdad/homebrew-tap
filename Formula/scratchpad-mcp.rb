class ScratchpadMcp < Formula
  desc "Private project memory for developers and coding agents"
  homepage "https://github.com/alexcatdad/scratchpad"
  version "0.2.0"

  depends_on "git"
  depends_on "openssh"

  on_macos do
    on_arm do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v0.2.0/scratchpad-mcp-v0.2.0-darwin-arm64.zip"
        sha256 "e52197699b80019fc337594bee8316325f6ddb3c7d7e9b9a5e3fa31ce53d94cf"
    end
    on_intel do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v0.2.0/scratchpad-mcp-v0.2.0-darwin-amd64.zip"
        sha256 "f3e2a5f1073632d14eefbeaca0120622f45a9259aaa1810153e6139acaf92de9"
    end
  end

  on_linux do
    on_arm do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v0.2.0/scratchpad-mcp-v0.2.0-linux-arm64.tar.gz"
        sha256 "c3cb6d87d2b01240cf77bb3a5146e812672ce552bcbfd3ae2e7382cd27839fd2"
    end
    on_intel do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v0.2.0/scratchpad-mcp-v0.2.0-linux-amd64.tar.gz"
        sha256 "f67a0e637dcb1d4efd022a6d3eeea53910355a8ba715a8ca6d1d4e49738fd2c7"
    end
  end

  def install
    bin.install "scratchpad-mcp"
  end

  test do
    assert_equal "scratchpad-mcp #{version}", shell_output("#{bin}/scratchpad-mcp --version").strip
  end
end
