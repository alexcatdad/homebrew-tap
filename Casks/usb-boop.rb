cask "usb-boop" do
  version "2026.11.07.1"
  sha256 "147f1780a42b8afc013d159919a18509838a12b4e01a08816ec7ff7f05827ba5"

  url "https://github.com/alexcatdad/usb-boop/releases/download/v2026.11.07.1/usb-boop-macos-arm64.zip"
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
