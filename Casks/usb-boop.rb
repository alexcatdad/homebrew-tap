cask "usb-boop" do
  version "2026.11.06.1"
  sha256 "230081aa89cc7fe97e6a4a2750b35addf62a8958a451ff2a4e34fb33ca55495e"

  url "https://github.com/alexcatdad/usb-boop/releases/download/v2026.11.06.1/usb-boop-macos-arm64.zip"
  name "usb-boop"
  desc "Menu bar app that reports negotiated USB link speed"
  homepage "https://github.com/alexcatdad/usb-boop"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "usb-boop.app"

  # Kept alphabetical: brew style enforces Cask/ArrayAlphabetization.
  # The app is sandboxed, so its preferences live inside its container;
  # the loose plist is only left behind by pre-sandbox builds.
  zap trash: [
    "~/Library/Application Scripts/com.alexcatdad.usb-boop",
    "~/Library/Containers/com.alexcatdad.usb-boop",
    "~/Library/Preferences/com.alexcatdad.usb-boop.plist",
  ]
end
