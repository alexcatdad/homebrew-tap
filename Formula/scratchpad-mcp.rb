class ScratchpadMcp < Formula
  desc "Private project memory for developers and coding agents"
  homepage "https://github.com/alexcatdad/scratchpad"
  version "2026.10.1"

  deprecate! date: "2026-10-30", because: "is replaced by the Scratchpad app", replacement_cask: "scratchpad"

  depends_on "git"
  depends_on "openssh"

  on_macos do
    on_arm do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v2026.10.1/scratchpad-mcp-v2026.10.1-darwin-arm64.zip"
        sha256 "200ca3c3a2c8eb8c0beed581035ded8de5ba41af9481b6945215c8a330d03d3f"
    end
    on_intel do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v2026.10.1/scratchpad-mcp-v2026.10.1-darwin-amd64.zip"
        sha256 "9d80a539cad48004ce96e9d2b99fbf8f0da1f287d57084f772ab8a085d7d5015"
    end
  end

  on_linux do
    on_arm do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v2026.10.1/scratchpad-mcp-v2026.10.1-linux-arm64.tar.gz"
        sha256 "edb0b23adfeb5664f58ca8b27996824a8427fb970cd00d16da93860952ad6e28"
    end
    on_intel do
        url "https://github.com/alexcatdad/scratchpad/releases/download/v2026.10.1/scratchpad-mcp-v2026.10.1-linux-amd64.tar.gz"
        sha256 "743b68fc8a2811a8508eb6882461badcc86817ebdcc704ee27b0d9ac716b063b"
    end
  end

  def install
    bin.install "scratchpad-mcp"
  end

  test do
    assert_equal "scratchpad-mcp #{version}", shell_output("#{bin}/scratchpad-mcp --version").strip
  end
end
