---
title: Human Input Checklist
tags:
  - homebrew-tap
  - kb
  - blockers
aliases:
  - Human-Powered Tasks
  - Required Human Inputs
---

# Human Input Checklist

The running list of tasks that require a real human to provide access, credentials, machine setup, or product decisions.

> [!important]
> Keep this current so blockers do not stay trapped in chat history.

## Credentials And Access

- [ ] To let the upstream PR Nanny release workflow dispatch tap updates automatically, add a fine-grained token as `HOMEBREW_TAP_ACTIONS_TOKEN` in `alexcatdad/pr-nanny`. Scope it only to `alexcatdad/homebrew-tap` with Actions: write. The tap workflow uses its repository `GITHUB_TOKEN` for the reviewed PR; no tap secret is required.

## Environment And Tooling Decisions

- [ ] Record any machine setup, deployment, or tooling decisions still needed

## Product And Release Decisions

- [ ] Record any scope, readiness, or release decisions that require a human call

## Human Validation Tasks

- [ ] Record any validation that must happen on a real machine, real account, or real environment

## usb-boop release ownership

The maintainer has authorized local signing and current-version publication.
Developer ID signing and the notarization Keychain profile are available on
their Mac; future releases require that Mac and its signing access. No Apple
credential export to this tap or GitHub Actions is required. Follow the
[upstream release procedure](../docs/usb-boop-maintenance.md#local-signing-and-release-delivery).

## PR Nanny local signing

The existing local Developer ID identity and notarisation profile were verified for this release. No Apple key export or GitHub signing secret is required.

## Local release updater decisions

- [ ] Decide the open package-mapping questions in [local release updates](../docs/local-release-updates.md#decisions-needed) (`paw`, pr-nanny formula plus cask, scratchpad cask, README table, legacy script).
- [ ] Retire the tap GitHub App installation and its secrets (manual owner step).
- [ ] Accept the updater with a real release; only synthetic fixtures are tested so far.
