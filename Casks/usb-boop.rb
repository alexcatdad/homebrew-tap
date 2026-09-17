cask "usb-boop" do
  version "2026.09.17.0"
  sha256 "5046889e8670c3853a489790627f57b62da1a1c95c7ee0a1cd2316666d09a8c8"

  url "https://github.com/alexcatdad/usb-boop/releases/download/v2026.09.17.0/usb-boop-macos-arm64.zip"
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

  # The app is ad-hoc signed rather than notarized, so Gatekeeper would
  # otherwise refuse to launch it. Remove this once Developer ID signing
  # and notarization are in place.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-rd", "com.apple.quarantine", "{{appdir}}/usb-boop.app"]
  end

  # Kept alphabetical: brew style enforces Cask/ArrayAlphabetization.
  # The app is sandboxed, so its preferences live inside its container;
  # the loose plist is only left behind by pre-sandbox builds.
  zap trash: [
    "~/Library/Application Scripts/com.alexcatdad.usb-boop",
    "~/Library/Containers/com.alexcatdad.usb-boop",
    "~/Library/Preferences/com.alexcatdad.usb-boop.plist",
  ]
end
