class Paw < Formula
  desc "Personal dotfiles manager CLI"
  homepage "https://alexcatdad.github.io/paw/"
  license "MIT"
  version "0.1.0"

  on_macos do
    on_arm do
      url "https://github.com/alexcatdad/paw/releases/download/v#{version}/paw-darwin-arm64"
      sha256 "3aad72163cc2dd5952167c6041372ab59688eb07c3582910d75150b55f96dd69"
    end

    on_intel do
      url "https://github.com/alexcatdad/paw/releases/download/v#{version}/paw-darwin-x64"
      sha256 "686cb5ec722fa02715cba92bbc27922ef8b5dfeafa119d2cb6cddbfb3233e89f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/alexcatdad/paw/releases/download/v#{version}/paw-linux-arm64"
      sha256 "72d02565cc6da50d9a051b9838c587886621f7cabeed71a40cb0f0f526ae45f7"
    end

    on_intel do
      url "https://github.com/alexcatdad/paw/releases/download/v#{version}/paw-linux-x64"
      sha256 "548fe8586db80626115530262b2c3606e79bf557b0bcb33061b4baee7abc5c44"
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
