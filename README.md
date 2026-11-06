# Homebrew Tap

Homebrew formulae for [alexcatdad](https://github.com/alexcatdad) tools.

## Usage

```bash
brew tap alexcatdad/tap
```

## Packages

<!-- BEGIN FORMULAE -->
| Formula | Version | Description |
|---------|---------|-------------|
| [paw-proxy](https://github.com/alexcatdad/paw-proxy) | 2026.11.06.1 | Zero-config HTTPS proxy for local development (signed macOS ARM64 app cask; puts `paw-proxy` and `up` on PATH) |
| [paw](https://github.com/alexcatdad/paw) | 0.5.0 | Personal dotfiles manager CLI |
| [pr-nanny](https://github.com/alexcatdad/pr-nanny) | 0.1.0-rc.6 | Passive GitHub pull-request monitor (signed macOS ARM64 cask) |
| [scratchpad](https://github.com/alexcatdad/scratchpad) | 2026.10.3 | Menu bar app for private developer memory (signed macOS ARM64 cask; installs only on the owner's tailnet, see below) |
| [scratchpad-mcp](https://github.com/alexcatdad/scratchpad) | 2026.10.1 (deprecated) | Replaced by the Scratchpad app cask, which bundles the MCP server |
| [usb-boop](https://github.com/alexcatdad/usb-boop) | 2026.09.17.5 | Menu bar app that reports negotiated USB link speed (cask) |
<!-- END FORMULAE -->

### Install

<!-- BEGIN INSTALL -->
```bash
brew install --cask alexcatdad/tap/paw-proxy
brew install alexcatdad/tap/paw
brew install --cask alexcatdad/tap/pr-nanny
brew install --cask alexcatdad/tap/scratchpad
brew install --cask alexcatdad/tap/usb-boop
```

<!-- END INSTALL -->

`tap_migrations.json` moves users of the retired `paw-proxy` formula to the
`paw-proxy` cask: on their next `brew update`, Homebrew unlinks the formula and
installs the cask (then suggests `brew uninstall --formula --force paw-proxy`).

Scratchpad releases are published only on the owner's Forgejo
(`forgejo.triceratops-dory.ts.net`), which requires sign-in. The `scratchpad`
cask installs only on the owner's tailnet and sends `HOMEBREW_FORGEJO_TOKEN`, a
read-only token of the `scratchpad-releases` account, which Homebrew loads from
`brew.env` (`~/.homebrew/brew.env` or `$XDG_CONFIG_HOME/homebrew/brew.env`).
