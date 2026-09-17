# usb-boop cask maintenance

The authoritative generator is `scripts/update_homebrew_tap.sh` in
`alexcatdad/usb-boop`. Change both the generator and this cask to avoid release
regressions. Preserve version, checksum, and artifact URL for metadata fixes.

Validate a generated copy in a disposable tap:

```sh
brew tap-new alexcatdad/usbboopcheck --no-git
cp Casks/usb-boop.rb "$(brew --repository alexcatdad/usbboopcheck)/Casks/"
brew trust --cask alexcatdad/usbboopcheck/usb-boop
brew style --cask alexcatdad/usbboopcheck/usb-boop
HOMEBREW_DEVELOPER=1 brew info --cask alexcatdad/usbboopcheck/usb-boop
brew untrust --cask alexcatdad/usbboopcheck/usb-boop
brew untap alexcatdad/usbboopcheck
```

2026-09-17: removed deprecated `url verified:`. Homebrew 7 style and developer
mode loading pass. The old cask fails developer mode loading. Generator output
matches the corrected cask byte for byte. No application release or reinstall
is needed for this metadata change.
