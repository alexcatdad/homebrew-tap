cask "usb-boop" do
  version "2026.03.31.0"
  sha256 "e5dda0ce903a0440acccea11a7a48c807a5720d13ad9328ae1bab3221add28c0"

  url "https://github.com/alexcatdad/usb-boop/releases/download/v2026.03.31.0/usb-boop-macos-arm64.zip"
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
