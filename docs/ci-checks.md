# Hosted CI checks

GitHub Actions parses every Ruby formula and cask on a disposable GitHub-hosted macOS runner for pull requests and main-branch pushes. The workflow reads repository source without installing packages or changing release artifacts.

Reproduce the check from the repository root:

```sh
for file in Formula/*.rb Casks/*.rb; do
  ruby -c "$file" || exit
done
git diff --check
```

Syntax checking does not prove download checksums, installation or application behavior. The existing upstream release verification and [usb-boop maintenance procedure](usb-boop-maintenance.md) remain the release gate.
