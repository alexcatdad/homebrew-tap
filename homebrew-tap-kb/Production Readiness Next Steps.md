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
