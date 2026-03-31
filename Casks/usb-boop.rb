cask "usb-boop" do
  version "2026.03.31.1"
  sha256 "8f497232713d9cf87afa92c2bf299f2cdd3c105c245f37ab85cc8c1eaef5adaa"

  url "https://github.com/alexcatdad/usb-boop/releases/download/v2026.03.31.1/usb-boop-macos-arm64.zip"
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
