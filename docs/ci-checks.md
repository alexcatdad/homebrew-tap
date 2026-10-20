# Hosted CI checks

GitHub Actions parses every Ruby formula and cask and styles the PR Nanny manifests on a disposable GitHub-hosted macOS runner for pull requests and main-branch pushes. Separate disposable macOS ARM64 and Ubuntu 24.04 x64 jobs install and uninstall only the PR Nanny cask or formula from the checked-out manifests. The Linux job provides the documented GTK4, WebKitGTK 6, Secret Service and D-Bus packages. The checks download the qualified release archives selected by the checked-out manifests (currently RC1) and do not launch the application or exercise its UI or credential-store behavior.

Reproduce the check from the repository root:

```sh
for file in Formula/*.rb Casks/*.rb; do
  ruby -c "$file" || exit
done
git diff --check
HOMEBREW_NO_AUTO_UPDATE=1 brew style Casks/pr-nanny.rb Formula/pr-nanny.rb
```

Local syntax checking does not prove package installation or application behavior. Hosted install/uninstall checks verify Homebrew's archive download checksum and package deployment/removal. They do not prove application launch, UI behavior, or Secret Service use. The existing upstream release verification and [usb-boop maintenance procedure](usb-boop-maintenance.md) remain the release gate.
