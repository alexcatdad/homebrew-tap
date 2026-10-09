# Homebrew Tap

Homebrew formulae for [alexcatdad](https://github.com/alexcatdad) tools.

## Usage

```bash
brew tap alexcatdad/tap
```

## Formulae

<!-- BEGIN FORMULAE -->
| Formula | Version | Description |
|---------|---------|-------------|
| [paw-proxy](https://github.com/alexcatdad/paw-proxy) | 1.12.1 | Zero-config HTTPS proxy for local macOS development |
| [paw](https://github.com/alexcatdad/paw) | 0.5.0 | Personal dotfiles manager CLI |
| [usb-boop](https://github.com/alexcatdad/usb-boop) | 0.0.0-dev | Linux desktop USB speed app (development preview formula) |
| [usb-boop](https://github.com/alexcatdad/usb-boop) | 2026.09.17.5 | Menu bar app that reports negotiated USB link speed (cask) |
<!-- END FORMULAE -->

### Install

<!-- BEGIN INSTALL -->
```bash
brew install alexcatdad/tap/paw-proxy
brew install alexcatdad/tap/paw
brew install --cask alexcatdad/tap/usb-boop
```

<!-- END INSTALL -->

### usb-boop platforms

On macOS: `brew install --cask alexcatdad/tap/usb-boop`.
On Linux (x86_64 or ARM64): `brew install --formula alexcatdad/tap/usb-boop`.
The Linux formula builds the Qt desktop app from source and does not change system services.
Launch `usb-boop` from a terminal. For launcher integration, ensure Homebrew's `share`
directory is in your session's `XDG_DATA_DIRS`. GNOME tray access may require an
AppIndicator extension; a normal application window is always available.

The initial Linux formula is an unreleased development preview (`0.0.0-dev`) pinned to
the Linux support app PR commit. It must land after that app PR; future stable releases
replace the source pin with their reviewed release commit and CalVer version.
