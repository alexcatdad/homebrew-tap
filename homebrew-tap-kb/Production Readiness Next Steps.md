---
title: Production Readiness Next Steps
tags:
  - homebrew-tap
  - kb
  - prod
aliases:
  - Production Push Checklist
  - Prod Readiness Checklist
---

# Production Readiness Next Steps

The focused checklist for getting `homebrew-tap` from “working enough to demo” to “honestly trustworthy to use or release.”

> [!important]
> Keep this note short, prioritized, and honest.

## Priority Order

### 1. Core correctness

- [ ] Confirm the most important user-facing or operator-facing workflows behave correctly
- [ ] Close the biggest reliability or correctness gaps still known in the repo

### 2. Operational confidence

- [ ] Make sure debugging, status, or observability surfaces are good enough for real use
- [ ] Document any heavy verification or release checks that matter before wider use

### 3. Release confidence

- [ ] Confirm docs match shipped behavior
- [ ] Confirm what still blocks a broader rollout, release, or recommendation

## Production Exit Criteria

The repo is ready for a broader push when:

- [ ] critical workflows are trustworthy
- [ ] the biggest operational gaps are closed or explicitly accepted
- [ ] release blockers are visible and small enough to manage


## usb-boop Homebrew 7

Local style and developer-mode cask loading pass after removing `verified:`.
The compatibility fix is published in the current cask.

## usb-boop signed release transition

- [x] Deliver the first locally signed and notarized release, `2026.09.17.4`; the earlier `2026.09.17.3` archive remains unchanged.
- [x] Confirm upstream release verification succeeds and the automatic cask update matches its version, URL, and checksum without quarantine removal.

These are delivery checks, not claims of manual hardware or UI acceptance.
The [maintenance runbook](../docs/usb-boop-maintenance.md) links the successful
verification workflow and delivered cask commit.

## Hosted source checks

[CI checks](../docs/ci-checks.md) now define the reproducible source gate. Hosted acceptance is established by the checks on the exact PR commit; source changes alone do not prove release or deployment acceptance.

## Linux usb-boop preview

- [ ] Confirm native x86_64/ARM64 formula source installation and tests on the final PR commit.
- [ ] Confirm the unchanged signed Mac cask installation gate on the final PR commit.
- [ ] Merge only after the upstream Linux support PR; no release is published by these changes.
- Physical hardware and desktop-session acceptance remain documented upstream.

Local validation for the Linux implementation candidate `598b69e`: generated source formula
style/strict audit and workflow syntax/security lint pass. Native x86_64 Ubuntu
24.04 (Qt 6.4.2) and Fedora 44 (Qt 6.11.2) build/test/package and clean runtime-only
installation checks pass; Ubuntu X11/Wayland headless smoke passes. The final tap
commit's hosted checks establish both architectures and signed Mac installation.
See [app PR 17](https://github.com/alexcatdad/usb-boop/pull/17) and
[tap PR 5](https://github.com/alexcatdad/homebrew-tap/pull/5) for exact commit checks.

The final formula pins app commit `a2b4be6`, which additionally makes release
version output verification exact. Existing DEB/RPM verification accepts the
correct version and rejects a near-matching version; a prefix-collision fixture
is also rejected. Prior hosted app and tap candidates passed all gates on both
Linux architectures and Mac; final pin checks remain required before merge.

The dark-mode tray follow-up pins app `be1ca181`. Local Debug and sanitizer suites
pass, including appearance selection, unknown preference fallback and alpha
preservation. Actual KDE portal preference and tray pixmap evidence exists. The
repinned tap must pass native formula installation/tests on both architectures
and the unchanged Mac installation gate before the follow-up is complete.
