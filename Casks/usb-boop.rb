cask "usb-boop" do
  version "2026.03.31.4"
  sha256 "a481ae835b7d74b5048e6fdc3c3787613402292e9910d46bf96788161cd1133f"

  url "https://github.com/alexcatdad/usb-boop/releases/download/v2026.03.31.4/usb-boop-macos-arm64.zip"
  name "usb-boop"
  desc "Native macOS menu bar app for USB connection speed detection"
  homepage "https://github.com/alexcatdad/usb-boop"
  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "usb-boop.app"

  zap trash: [
    "~/Library/Preferences/com.alexcatdad.usb-boop.plist",
  ]
end
