class UsbBoop < Formula
  desc "Desktop app that reports negotiated USB link speed"
  homepage "https://github.com/alexcatdad/usb-boop"
  url "https://github.com/alexcatdad/usb-boop/archive/a2b4be6d461e2ac4bfeefb496ef127c499235c45.tar.gz"
  version "0.0.0-dev"
  sha256 "622ff5f30a9fe28b1a378e5ab9c0f417f916bbcde1f3df7b484ffe8631cb493f"
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
