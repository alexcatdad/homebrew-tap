class ScratchpadMcp < Formula
  desc "Private project memory for developers and coding agents"
  homepage "https://github.com/alexcatdad/scratchpad"
  version "0.1.3"

  depends_on "git"
  depends_on "openssh"

  on_macos do
    on_arm do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v0.1.3/scratchpad-mcp-v0.1.3-darwin-arm64.zip"
        sha256 "ddb4258ed0b20b4bd7d4a849ab8e83edd853d1fd6ade724e5507bc631907d9d6"
    end
    on_intel do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v0.1.3/scratchpad-mcp-v0.1.3-darwin-amd64.zip"
        sha256 "2edd3cc11e3d53dc717971bf8b7d01c4e88e84d229fcf47fa198ad948d3ce87c"
    end
  end

  on_linux do
    on_arm do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v0.1.3/scratchpad-mcp-v0.1.3-linux-arm64.tar.gz"
        sha256 "bdcff0d91b7304871915c953290cf26f90bde734f21bec94c2ab085e0d4b77d5"
    end
    on_intel do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v0.1.3/scratchpad-mcp-v0.1.3-linux-amd64.tar.gz"
        sha256 "dcb0350da921732c4e27423aae23da8282a50d2801b90cb2dbd2caafa46d1ae1"
    end
  end

  def install
    bin.install "scratchpad-mcp"
  end

  test do
    assert_equal "scratchpad-mcp #{version}", shell_output("#{bin}/scratchpad-mcp --version").strip
  end
end
