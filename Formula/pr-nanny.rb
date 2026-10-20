class PrNanny < Formula
  desc "Passive GitHub pull-request monitor"
  homepage "https://github.com/alexcatdad/pr-nanny"
  url "https://github.com/alexcatdad/pr-nanny/releases/download/v0.1.0-rc.1/pr-nanny-0.1.0-rc.1-linux-x64.tar.gz"
  version "0.1.0-rc.1"
  sha256 "29f2227a20a597211afa1854dc5a8aecb6c2c27c1356c7fc662750a699000e47"
  license "MIT"

  depends_on :linux

  def install
    odie "PR Nanny Linux packages require x86_64" unless Hardware::CPU.intel?
    bin.install "bin/pr-nanny"
    (share/"applications").install "share/applications/pr-nanny.desktop"
    (share/"icons/hicolor/256x256/apps").install "share/icons/hicolor/256x256/apps/pr-nanny.png"
    pkgshare.install "scripts/apparmor-profile.sh", "APPARMOR.md"
  end

  def caveats
    <<~EOS
      Requires GTK4, WebKitGTK 6.0, a Secret Service provider and glibc 2.39 or newer.
      The Linux archive is built on Ubuntu 24.04.
    EOS
  end

  test do
    assert_predicate bin/"pr-nanny", :executable?
  end
end
