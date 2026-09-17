# usb-boop cask maintenance

The authoritative generator is `scripts/update_homebrew_tap.sh` in
`alexcatdad/usb-boop`. Change both the generator and this cask to avoid release
regressions. Preserve version, checksum, and artifact URL for metadata fixes.

## Local signing and release delivery

The first Developer ID-signed and Apple-notarized release,
[`2026.09.17.4`](https://github.com/alexcatdad/usb-boop/releases/tag/v2026.09.17.4),
is published. The earlier ad-hoc-signed `2026.09.17.3` archive remains unchanged.

The maintainer builds, signs, and notarizes the reviewed source on their Mac.
Apple credentials and the signing private key stay in the local Keychain.
Follow the upstream [local signed release runbook](https://github.com/alexcatdad/usb-boop/blob/main/docs/development-runbook.md#local-signed-release)
for source checks, notarization, verification, and publication.

The upstream delivery workflow verifies the published download before
automatically updating this tap's cask and README version table. The signed
release's generated cask has removed the quarantine-removal `postflight_steps`;
normal Gatekeeper checks must remain enabled. A source merge alone no longer
publishes a binary. Do not update this tap to an unverified artifact or
reintroduce the quarantine bypass.

After delivery, verify the remote cask version, archive URL, checksum, and
absence of quarantine removal against the verified release. Keep the current
installed app and its preferences unchanged during this inspection.

For `2026.09.17.4`, both independent macOS package verification and tap delivery
[passed](https://github.com/alexcatdad/usb-boop/actions/runs/35250073519).
Tap commit [`6e61f86`](https://github.com/alexcatdad/homebrew-tap/commit/6e61f86f282df365fce806475aec50186a342557)
sets the matching version and release URL, SHA-256
`8ba593b72af0a6e666e52640f68a7810525d3ec4d3d251b146686499fa69f973`,
and contains no quarantine bypass. This establishes delivery validation, not
additional manual hardware or UI acceptance.

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
