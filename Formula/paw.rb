class Paw < Formula
  desc "Personal dotfiles manager CLI"
  homepage "https://alexcatdad.github.io/paw/"
  license "MIT"
  version "0.5.0"

  on_macos do
    on_arm do
      url "https://github.com/alexcatdad/paw/releases/download/v#{version}/paw-darwin-arm64"
      sha256 "1c2ebb1327c44bc26de62e2107471c48226298df15829288eeb3ea75fa147b1b"
    end

    on_intel do
      url "https://github.com/alexcatdad/paw/releases/download/v#{version}/paw-darwin-x64"
      sha256 "ab5cc7e87b0480977f18f74fd20c3c68efda8e05ce31c6512c649641bb30b9d7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/alexcatdad/paw/releases/download/v#{version}/paw-linux-arm64"
      sha256 "81161d6d9baf71c2179ba45d8d8ce8ceb7cf32cacff699d85ea993a66c882574"
    end

    on_intel do
      url "https://github.com/alexcatdad/paw/releases/download/v#{version}/paw-linux-x64"
      sha256 "0ca615ac256798fd4de4a754a2eaa00deb5df7130b899e5e09ee14f8f63aead1"
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
