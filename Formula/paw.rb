class Paw < Formula
  desc "Personal dotfiles manager CLI"
  homepage "https://alexcatdad.github.io/paw/"
  license "MIT"
  version "0.3.0"

  on_macos do
    on_arm do
      url "https://github.com/alexcatdad/paw/releases/download/v#{version}/paw-darwin-arm64"
      sha256 "e97dcc33d7192fda3fb438eeaaec0a50ca5eaed64c059bd89a128517fd51a6ff"
    end

    on_intel do
      url "https://github.com/alexcatdad/paw/releases/download/v#{version}/paw-darwin-x64"
      sha256 "79d6116900247a7f56e99b260ee0df18c62a1567b4ea31ad49f8002f1c8da2f7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/alexcatdad/paw/releases/download/v#{version}/paw-linux-arm64"
      sha256 "7868606f83c1ffceb4e6e444fe2e458fa499f92cef76a35660f622905f734120"
    end

    on_intel do
      url "https://github.com/alexcatdad/paw/releases/download/v#{version}/paw-linux-x64"
      sha256 "1f1d0ee394189c4436a47d65c808fdd870273b4ec7fb2c6a9488dddd2630f547"
    end
  end

  def install
    binary = Dir["paw-*"].first || "paw"
    bin.install binary => "paw"
  end

  test do
    assert_match "paw", shell_output("#{bin}/paw --help")
  end
end
