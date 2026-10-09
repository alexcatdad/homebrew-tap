# Hosted CI checks

GitHub Actions parses every Ruby formula and cask on disposable GitHub-hosted
macOS runners for pull requests and main pushes. For usb-boop, additional jobs
build and test the Linux source formula on native Ubuntu 24.04 x86_64 and ARM64,
and install the existing signed Mac cask on macOS 26.

Linux gates run Homebrew style and strict audit, source installation, the formula
fixture test, version output and JSON enumeration. Mac gates run style, developer
DSL loading, download/checksum validation through Homebrew, installation,
`codesign --verify --deep --strict` and Gatekeeper assessment. Neither job publishes
or changes release artifacts. Other tap packages retain their existing syntax gate.

Reproduce source checks from the repository root:

```sh
for file in Formula/*.rb Casks/*.rb; do
  ruby -c "$file" || exit
done
git diff --check
```

Use a disposable environment for install checks. Successful package installation
does not prove physical hotplug, resume or desktop tray behavior. The upstream
[usb-boop maintenance procedure](usb-boop-maintenance.md) remains the release gate.
