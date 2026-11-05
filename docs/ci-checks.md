# Hosted CI checks

GitHub Actions parses every Ruby formula and cask and styles the PR Nanny cask on a disposable GitHub-hosted macOS runner for pull requests and main-branch pushes. A separate disposable macOS ARM64 job installs and uninstalls only the PR Nanny cask from the checked-out manifest. The PR Nanny Linux formula and its Ubuntu job were retired on 2026-11-05. The checks download the qualified release archives selected by the checked-out manifest and do not launch the application or exercise its UI or credential-store behavior.

Reproduce the check from the repository root:

```sh
for file in Formula/*.rb Casks/*.rb; do
  ruby -c "$file" || exit
done
git diff --check
HOMEBREW_NO_AUTO_UPDATE=1 brew style Casks/pr-nanny.rb
```

Local syntax checking does not prove package installation or application behavior. Hosted install/uninstall checks verify Homebrew's archive download checksum and package deployment/removal. They do not prove application launch, UI behavior, or Secret Service use. The existing upstream release verification and [usb-boop maintenance procedure](usb-boop-maintenance.md) remain the release gate.

The syntax job also runs `sh tests/run.sh`, which exercises the local release updater against synthetic fixtures. See [local release updates](local-release-updates.md). Workflows in this repository are validation-only.
