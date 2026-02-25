class Paw < Formula
  desc "Personal dotfiles manager CLI"
  homepage "https://alexcatdad.github.io/paw/"
  license "MIT"
  version "0.4.0"

  on_macos do
    on_arm do
      url "https://github.com/alexcatdad/paw/releases/download/v#{version}/paw-darwin-arm64"
      sha256 "010564503c11c387ede55b7e3d9b195d8565f2030371c1a6699e6bff34382b0e"
    end

    on_intel do
      url "https://github.com/alexcatdad/paw/releases/download/v#{version}/paw-darwin-x64"
      sha256 "e9cd8073688dc3ced3abf2891bf456f9042e037187643e7143d012bb2f703d05"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/alexcatdad/paw/releases/download/v#{version}/paw-linux-arm64"
      sha256 "cd3caa59721ca7d9aba8837ec782360672a38dec11f39d1fe0f67215133fb914"
    end

    on_intel do
      url "https://github.com/alexcatdad/paw/releases/download/v#{version}/paw-linux-x64"
      sha256 "e4b9db63843ffec2fd4d0868a810d2cad68260dfe26404f1fb75ead4c8d4bfa7"
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
