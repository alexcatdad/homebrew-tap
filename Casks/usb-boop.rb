cask "usb-boop" do
  version "2026.03.31.5"
  sha256 "25498cc2eeacc1c1c48ec29dda20d75c6a123fe51e34ab6ccc56da282397069d"

  url "https://github.com/alexcatdad/usb-boop/releases/download/v2026.03.31.5/usb-boop-macos-arm64.zip"
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
