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
