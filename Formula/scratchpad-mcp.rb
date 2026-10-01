class ScratchpadMcp < Formula
  desc "Private project memory for developers and coding agents"
  homepage "https://github.com/alexcatdad/scratchpad"
  version "0.3.0"

  depends_on "git"
  depends_on "openssh"

  on_macos do
    on_arm do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v0.3.0/scratchpad-mcp-v0.3.0-darwin-arm64.zip"
        sha256 "d14d36c1050c5d4c92c8eb776056cd7e1657d2b5ca461a1baa6f010d38873fae"
    end
    on_intel do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v0.3.0/scratchpad-mcp-v0.3.0-darwin-amd64.zip"
        sha256 "3f692488d275d049dbcb92f147a551c1cd1ba156aaa6c2e9a27de4cdba124a9d"
    end
  end

  on_linux do
    on_arm do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v0.3.0/scratchpad-mcp-v0.3.0-linux-arm64.tar.gz"
        sha256 "a7f0fc3abd66e28e7dca6754ff2897ff1ee88be6e891614a4357b27184642571"
    end
    on_intel do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v0.3.0/scratchpad-mcp-v0.3.0-linux-amd64.tar.gz"
        sha256 "f2bcfe921bf5a1171ec525d57e88b8550877dfa59f635560d91a8adddcad6966"
    end
  end

  def install
    bin.install "scratchpad-mcp"
  end

  test do
    assert_equal "scratchpad-mcp #{version}", shell_output("#{bin}/scratchpad-mcp --version").strip
  end
end
