class PrNanny < Formula
  desc "Passive GitHub pull-request monitor"
  homepage "https://github.com/alexcatdad/pr-nanny"
  url "https://github.com/alexcatdad/pr-nanny/releases/download/v0.1.0-rc.4/pr-nanny-0.1.0-rc.4-linux-x64.tar.gz"
  version "0.1.0-rc.4"
  sha256 "a7713736388b8273f7e950e953bea39ce71c6703efd1d44085cda7d529208888"
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
