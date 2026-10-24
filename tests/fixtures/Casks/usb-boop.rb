cask "usb-boop" do
  version "2026.09.17.5"
  sha256 "0000000000000000000000000000000000000000000000000000000000000001"

  url "https://github.com/example-org/usb-boop/releases/download/v2026.09.17.5/usb-boop-macos-arm64.zip"
  name "usb-boop"
  desc "Menu bar app that reports negotiated USB link speed"
  homepage "https://github.com/example-org/usb-boop"

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
    "~/Library/Application Scripts/com.example.usb-boop",
    "~/Library/Containers/com.example.usb-boop",
    "~/Library/Preferences/com.example.usb-boop.plist",
  ]
end
