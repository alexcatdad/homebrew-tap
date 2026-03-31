cask "usb-boop" do
  version "2026.03.31.2"
  sha256 "c6ae99497b05341a17aadcf0b2dcf3f96151f622b99e81210e3ed2b6e86ecd81"

  url "https://github.com/alexcatdad/usb-boop/releases/download/v2026.03.31.2/usb-boop-macos-arm64.zip"
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
