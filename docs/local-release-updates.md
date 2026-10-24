# Local release updates

Package definitions in this tap are advanced by an explicitly invoked local
release task, after an application release is published and its final bytes are
verified. GitHub Actions in this repository only validate; no workflow writes to
the tap.

## Flow

The local release tool keeps its own clone of this tap and, per verified release:

1. resets the clone to the default branch,
2. writes a `release-tools/tap-update/v1` JSON document to a file,
3. runs `scripts/apply-release-update <file>` from the repository root,
4. inspects `git status`: no change means success without a commit; otherwise it
   commits and pushes with the owner's local git credentials.

`scripts/apply-release-update` edits the working tree only. It never commits,
pushes, fetches or touches the network, so a failed delivery can be retried by
re-running the same document without rebuilding or re-releasing anything.

## Input document

```json
{
  "schema": "release-tools/tap-update/v1",
  "app": "example-app",
  "kind": "formula",
  "package": "example-app",
  "version": "2026.10.1",
  "tag": "v2026.10.1",
  "repo": "example-org/example-app",
  "assets": [
    {"os": "darwin", "arch": "arm64", "kind": "tar.gz",
     "url": "https://github.com/example-org/example-app/releases/download/v2026.10.1/example-app-2026.10.1-darwin-arm64.tar.gz",
     "sha256": "<64 lowercase hex>"}
  ]
}
```

- `kind`: `formula` or `cask`. `os`: `darwin` or `linux`. `arch`: `arm64`,
  `amd64` or `universal`. Asset `kind`: `binary`, `tar.gz`, `zip`, `dmg`, `pkg`, `rpm`.
- `version` is dotted numeric; `tag` is the version, optionally prefixed with `v`.
- Every URL is `https://github.com/<repo>/releases/download/<tag>/<file>`.
- A cask carries only `darwin` assets.

## Matching assets to the package file

The package file is `Formula/<package>.rb` or `Casks/<package>.rb`. Each
`url`/`sha256` pair in it is a slot. A slot is matched to the asset whose file
name equals the slot's file name once the old and new version/tag are
normalised, so `tool-v1.2.3-darwin-arm64.zip` pairs with
`tool-v2026.10.1-darwin-arm64.zip`. Every slot must match exactly one asset (a missing one is exit 2).
Assets that no slot uses are allowed (apps publish more files than a formula
installs) and are reported one per line on stderr as `ignored asset: <file>`;
they do not change the exit code. File names without a version, such as
`paw-proxy-darwin-arm64` under a new tag, match by identical name. Where a slot sits inside `on_macos`,
`on_linux`, `on_arm` or `on_intel`, the asset's `os`/`arch` must agree.
A release that renames a file the package installs, or drops a platform it covers, is rejected (exit 2)
and needs a deliberate manual edit of the package file. Only `version`, `url`
and `sha256` lines change; the result must pass `ruby -c` before it is written.
Slots with interpolated URLs (`#{version}`) are unsupported.

## Exit codes

| Code | Meaning |
|------|---------|
| 0 | Applied, or already identical (tree unchanged) |
| 2 | Invalid input: schema, URL prefix, hashes, cask with non-darwin assets, unknown package or package not owned by `app`, a package slot with no matching asset |
| 3 | Regression: the package already has a newer version |
| 4 | Same version already present with different URLs or hashes |
| other | Failure (unreadable file, unsupported layout, syntax check failed) |

On any non-zero exit a one-line reason is written to stderr and the tree is
unchanged. Versions compare numerically per dotted component, ignoring a `v`
prefix and any pre-release suffix, so `0.3.0` < `1.12.3` < `2026.9.17.5` <
`2026.10.1`.

## Package ownership

| App | Owned entries | Platforms |
|-----|---------------|-----------|
| scratchpad | `Formula/scratchpad-mcp.rb` | macOS arm64/amd64, Linux arm64/amd64. No cask. |
| usb-boop | `Casks/usb-boop.rb` | macOS arm64 only |
| pr-nanny | `Casks/pr-nanny.rb` (macOS arm64), `Formula/pr-nanny.rb` (Linux x64) | separate documents per kind |
| paw-proxy | `Formula/paw-proxy.rb` | macOS arm64/amd64 |

Casks are macOS-only; Linux uses a formula. The updater rejects any package not
listed above, including `Formula/paw.rb`, which no application owns here.
No package is renamed or removed by this change.

### Decisions needed

1. `Formula/paw.rb` versus `Formula/paw-proxy.rb`. `paw` (dotfiles manager, 0.5.0)
   and `paw-proxy` (HTTPS proxy, 1.12.3) are different tools with different
   upstream repositories, so the current mapping treats `paw-proxy` as the
   fourth application and leaves `paw` unmanaged by this updater. Choose: keep
   `paw` as a manually maintained formula, add it as a fifth application, or
   remove it.
2. pr-nanny formula and cask. They cover different platforms (Linux x64 formula,
   macOS arm64 cask) and are updated by separate documents. Choose: keep both
   (current behaviour) or retire the formula. If the Linux package is kept, its
   releases must keep publishing a `linux-x64.tar.gz` asset.
3. scratchpad has no cask. Confirm a formula-only package is intended.
4. `scripts/update-pr-nanny.sh` was the helper for the deleted workflow. It is
   kept and unreferenced; remove it once the local task is accepted.
5. The README package table is not touched by the updater (only the named
   package file changes). Decide whether the local task should also refresh it.
6. Retiring the tap GitHub App installation and its secrets is a manual owner
   step in repository/account settings.

## Tests

```sh
sh tests/run.sh
```

Runs the updater against synthetic fixtures in `tests/fixtures` (fake
organisation, URLs and hashes) copied to a temporary directory. It covers a
correct update, no-op reapply, stale version, mismatched assets, invalid or
missing assets, a cask with a Linux asset, and semver history ordering below
CalVer. CI runs it in the syntax job. `brew style`/`brew audit` and isolated
installs are not part of this test; the existing hosted install checks and the
release verification remain the gate for package behaviour.
