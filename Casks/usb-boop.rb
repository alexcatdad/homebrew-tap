cask "usb-boop" do
  version "2026.03.31.6"
  sha256 "63a689400f51b18beed47d948f17c073d32c1fee26f5d2dc542beb40519e82a8"

  url "https://github.com/alexcatdad/usb-boop/releases/download/v2026.03.31.6/usb-boop-macos-arm64.zip"
  name "usb-boop"
  desc "Native macOS menu bar app for USB connection speed detection"
  homepage "https://github.com/alexcatdad/usb-boop"
  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "usb-boop.app"

  # Remove quarantine flag since the app is ad-hoc signed, not notarized.
  # This will be removed once Developer ID signing is in place.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-rd", "com.apple.quarantine", "#{appdir}/usb-boop.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Preferences/com.alexcatdad.usb-boop.plist",
  ]
end
