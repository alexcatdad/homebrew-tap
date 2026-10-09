---
title: Decision Log
tags:
  - homebrew-tap
  - kb
  - decisions
aliases:
  - ADR Log
  - Decision Register
---

# Decision Log

The running log of decisions that materially affect `homebrew-tap`.

## How To Use This Note

- add an entry when a decision changes architecture, delivery posture, source-of-truth policy, or release posture
- include the decision, why it was made, and what it implies
- link the deeper canonical doc when one exists


## 2026-09-17: Homebrew 7 compatibility

Remove deprecated `url verified:` from usb-boop and its upstream generator.
Preserve artifact identity. Validation is documented in [the runbook](../docs/usb-boop-maintenance.md).

## 2026-09-17: Locally signed usb-boop releases

Keep Developer ID signing and Apple notarization on the maintainer's Mac, with
credentials in Keychain. Upstream verifies each published package before its
automatic tap update. The first signed version, `2026.09.17.4`, is published;
`2026.09.17.3` remains unchanged. The verified signed cask update removed the
quarantine bypass. Both upstream verification and tap delivery passed; see
[maintenance and release delivery](../docs/usb-boop-maintenance.md) for evidence.

## 2026-10-08: Public hosted CI

Run Ruby syntax checks for all formulae and casks on GitHub-hosted macOS for pull requests and main pushes. Keep artifact download, installation and signing verification in existing upstream release procedures. No homelab runner or package installation is part of this gate. See [CI checks](../docs/ci-checks.md).

## 2026-10-09: Separate Linux usb-boop formula

Add a Linux-only source formula alongside the unchanged signed Mac cask. The
initial development preview pins an immutable upstream PR commit; stable delivery
remains upstream-owned and independently gates the Linux and Mac entries. Expand
hosted usb-boop checks to native Linux builds/installations on both architectures
and signed Mac cask installation. See [CI checks](../docs/ci-checks.md) and
[maintenance](../docs/usb-boop-maintenance.md#linux-formula).

## 2026-10-09: Theme-aware Linux tray preview

Repin the Linux preview to app `be1ca181`, which selects a white tray icon in dark
appearance while retaining transparency, reads portal settings/changes and falls
back to the palette for unavailable or unknown preferences. The running KDE tray
registration and exported dark icon pixels were inspected on the coordinating
machine; other desktops and physical hardware limits remain explicitly separate.
See [app PR 17](https://github.com/alexcatdad/usb-boop/pull/17).
