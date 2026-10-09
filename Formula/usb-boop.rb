class UsbBoop < Formula
  desc "Desktop app that reports negotiated USB link speed"
  homepage "https://github.com/alexcatdad/usb-boop"
  url "https://github.com/alexcatdad/usb-boop/archive/be1ca1810356a79d393f8a3d30a02ef1c734a79a.tar.gz"
  version "0.0.0-dev"
  sha256 "2f85606635c4a384fd2291bdfeee7c3b7f082f12a7709bb46694c5a8c62775c3"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on :linux
  depends_on "qtbase"
  depends_on "qtwayland"
  depends_on "systemd"

  def install
    system "cmake", "-S", "linux", "-B", "build", "-G", "Ninja",
           "-DUSB_BOOP_VERSION=#{version}", "-DBUILD_TESTING=OFF", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  def caveats
    <<~EOS
      Start usb-boop from a terminal or your application launcher.
      If your desktop does not search Homebrew's share directory, add
      #{HOMEBREW_PREFIX}/share to XDG_DATA_DIRS before starting your session.
      GNOME may need an AppIndicator extension for tray access; the app also has a window.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/usb-boop --version")
    require "json"
    assert_kind_of Array, JSON.parse(shell_output("#{bin}/usb-boop --fixtures --list --json"))["devices"]
  end
end
