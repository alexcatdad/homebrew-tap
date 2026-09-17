# usb-boop cask maintenance

The authoritative generator is `scripts/update_homebrew_tap.sh` in
`alexcatdad/usb-boop`. Change both the generator and this cask to avoid release
regressions. Preserve version, checksum, and artifact URL for metadata fixes.

## Local signing and release delivery

The existing `2026.09.17.3` release is ad-hoc signed. Its archive must remain
unchanged. The first Developer ID-signed and Apple-notarized release is planned
as `2026.09.17.4`; do not describe it as published until delivery succeeds.

The maintainer builds, signs, and notarizes the reviewed source on their Mac.
Apple credentials and the signing private key stay in the local Keychain.
Follow the upstream [local signed release runbook](https://github.com/alexcatdad/usb-boop/blob/main/docs/development-runbook.md#local-signed-release)
for source checks, notarization, verification, and publication.

The new upstream delivery workflow verifies the published download before
automatically updating this tap's cask and README version table. The signed
release's generated cask removes the quarantine-removal `postflight_steps`;
normal Gatekeeper checks must remain enabled. A source merge alone no longer
publishes a binary. Do not update this tap to an unverified artifact or remove
the existing bypass ahead of the signed release's delivery.

After delivery, verify the remote cask version, archive URL, checksum, and
absence of quarantine removal against the verified release. Keep the current
installed app and its preferences unchanged during this inspection.

## Cask validation

Prefer upstream's ephemeral CI runner for generated-cask style and
developer-mode loading checks. Do not create or force-remove a local validation
tap with the installed `usb-boop` token: Homebrew 7 `untap --force` can uninstall
matching installed packages. Read-only inspection needs no tap installation:

```sh
git diff --check
ruby -c Casks/usb-boop.rb
rg -n 'version|sha256|url|postflight|quarantine' Casks/usb-boop.rb
```

Ruby syntax checking does not replace the upstream Homebrew checks. This
documentation transition changes no cask artifact or README version entry.

2026-09-17: removed deprecated `url verified:`. Homebrew 7 style and developer
mode loading pass. The old cask fails developer mode loading. Generator output
matches the corrected cask byte for byte. No application release or reinstall
is needed for this metadata change.
