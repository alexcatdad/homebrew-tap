#!/bin/sh
# Runs scripts/apply-release-update against synthetic fixtures in temp copies.
# Usage: sh tests/run.sh
set -u
root=$(CDPATH='' cd -- "$(dirname -- "$0")/.." && pwd)
tool="$root/scripts/apply-release-update"
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT HUP INT TERM
pass=0
fail=0
H1=$(printf 'a%.0s' $(seq 1 64))
H2=$(printf 'b%.0s' $(seq 1 64))
H3=$(printf 'c%.0s' $(seq 1 64))
H4=$(printf 'd%.0s' $(seq 1 64))
H5=$(printf 'e%.0s' $(seq 1 64))

# fresh: copy fixtures to a new temp tap; sets $tap
n=0
fresh() {
  n=$((n + 1))
  tap="$work/tap$n"
  mkdir -p "$tap"
  cp -R "$root/tests/fixtures/Formula" "$root/tests/fixtures/Casks" "$tap/"
}

# run_case <name> <expected-exit> <json> ; runs in $tap, sets $out_status
run_case() {
  name=$1 want=$2 json=$3
  printf '%s' "$json" > "$tap/update.json"
  err=$(cd "$tap" && "$tool" update.json 2>&1 >/dev/null)
  got=$?
  if [ "$got" -eq "$want" ]; then
    pass=$((pass + 1)); echo "ok   $name"
  else
    fail=$((fail + 1)); echo "FAIL $name: exit $got, want $want ($err)"
  fi
  if [ "$want" -ne 0 ] && [ -z "$err" ]; then
    fail=$((fail + 1)); echo "FAIL $name: no stderr reason"
  fi
}

# check <name> <command...>: assert a command succeeds
check() {
  name=$1; shift
  if "$@" >/dev/null 2>&1; then pass=$((pass + 1)); echo "ok   $name"
  else fail=$((fail + 1)); echo "FAIL $name"; fi
}

U=https://github.com/example-org
cask_json() { # version sha
  printf '{"schema":"release-tools/tap-update/v1","app":"usb-boop","kind":"cask","package":"usb-boop","version":"%s","tag":"v%s","repo":"example-org/usb-boop","assets":[{"os":"darwin","arch":"arm64","kind":"zip","url":"%s/usb-boop/releases/download/v%s/usb-boop-macos-arm64.zip","sha256":"%s"}]}' "$1" "$1" "$U" "$1" "$2"
}
scratch_json() { # version [sha-for-darwin-arm64]
  v=$1
  printf '{"schema":"release-tools/tap-update/v1","app":"scratchpad","kind":"formula","package":"scratchpad-mcp","version":"%s","tag":"v%s","repo":"example-org/scratchpad","assets":[
{"os":"darwin","arch":"arm64","kind":"zip","url":"%s/scratchpad/releases/download/v%s/scratchpad-mcp-v%s-darwin-arm64.zip","sha256":"%s"},
{"os":"darwin","arch":"amd64","kind":"zip","url":"%s/scratchpad/releases/download/v%s/scratchpad-mcp-v%s-darwin-amd64.zip","sha256":"%s"},
{"os":"linux","arch":"arm64","kind":"tar.gz","url":"%s/scratchpad/releases/download/v%s/scratchpad-mcp-v%s-linux-arm64.tar.gz","sha256":"%s"},
{"os":"linux","arch":"amd64","kind":"tar.gz","url":"%s/scratchpad/releases/download/v%s/scratchpad-mcp-v%s-linux-amd64.tar.gz","sha256":"%s"}]}' \
    "$v" "$v" "$U" "$v" "$v" "${2:-$H1}" "$U" "$v" "$v" "$H2" "$U" "$v" "$v" "$H3" "$U" "$v" "$v" "$H4"
}

# 1. correct update (cask)
fresh
run_case "cask update applies" 0 "$(cask_json 2026.10.1 $H1)"
check "cask has new version" grep -q 'version "2026.10.1"' "$tap/Casks/usb-boop.rb"
check "cask has new url" grep -q "$U/usb-boop/releases/download/v2026.10.1/usb-boop-macos-arm64.zip" "$tap/Casks/usb-boop.rb"
check "cask has new sha" grep -q "sha256 \"$H1\"" "$tap/Casks/usb-boop.rb"
check "cask zap block untouched" grep -q 'Containers/com.example.usb-boop' "$tap/Casks/usb-boop.rb"
check "cask still parses" ruby -c "$tap/Casks/usb-boop.rb"
check "other files untouched" diff -r "$root/tests/fixtures/Formula" "$tap/Formula"
check "pr-nanny cask untouched" cmp "$root/tests/fixtures/Casks/pr-nanny.rb" "$tap/Casks/pr-nanny.rb"

# 2. no-op reapply leaves bytes unchanged
cp "$tap/Casks/usb-boop.rb" "$work/before"
run_case "cask reapply is a no-op" 0 "$(cask_json 2026.10.1 $H1)"
check "no-op leaves file identical" cmp "$work/before" "$tap/Casks/usb-boop.rb"

# 3. stale version
run_case "stale version exits 3" 3 "$(cask_json 2026.9.17.5 $H1)"
check "stale leaves file identical" cmp "$work/before" "$tap/Casks/usb-boop.rb"
run_case "2026.9.17.5 < 2026.10.1 numerically" 3 "$(cask_json 2026.9.17.5 $H1)"

# 4. mismatched assets for the same version
run_case "same version, different sha exits 4" 4 "$(cask_json 2026.10.1 $H5)"
check "mismatch leaves file identical" cmp "$work/before" "$tap/Casks/usb-boop.rb"

# 5. semver history sorts below CalVer; multi-platform formula
fresh
run_case "formula 0.3.0 -> 2026.10.1 applies" 0 "$(scratch_json 2026.10.1)"
check "formula version updated" grep -q 'version "2026.10.1"' "$tap/Formula/scratchpad-mcp.rb"
check "formula all four shas set" sh -c "[ \$(grep -c -e '$H1' -e '$H2' -e '$H3' -e '$H4' '$tap/Formula/scratchpad-mcp.rb') -eq 4 ]"
check "formula parses" ruby -c "$tap/Formula/scratchpad-mcp.rb"
run_case "formula lower than 2026.10.1 exits 3" 3 "$(scratch_json 1.12.3)"
fresh
run_case "1.12.x < 2026.9.17.5 (paw-proxy history)" 0 "$(printf '{"schema":"release-tools/tap-update/v1","app":"paw-proxy","kind":"formula","package":"paw-proxy","version":"2026.9.17.5","tag":"v2026.9.17.5","repo":"example-org/paw-proxy","assets":[
{"os":"darwin","arch":"arm64","kind":"binary","url":"%s/paw-proxy/releases/download/v2026.9.17.5/paw-proxy-darwin-arm64","sha256":"%s"},
{"os":"darwin","arch":"arm64","kind":"binary","url":"%s/paw-proxy/releases/download/v2026.9.17.5/up-darwin-arm64","sha256":"%s"},
{"os":"darwin","arch":"amd64","kind":"binary","url":"%s/paw-proxy/releases/download/v2026.9.17.5/paw-proxy-darwin-amd64","sha256":"%s"},
{"os":"darwin","arch":"amd64","kind":"binary","url":"%s/paw-proxy/releases/download/v2026.9.17.5/up-darwin-amd64","sha256":"%s"},
{"os":"darwin","arch":"universal","kind":"tar.gz","url":"%s/paw-proxy/releases/download/v2026.9.17.5/man-pages.tar.gz","sha256":"%s"}]}' "$U" $H1 "$U" $H2 "$U" $H3 "$U" $H4 "$U" $H5)"
check "paw-proxy resources updated" grep -q "releases/download/v2026.9.17.5/man-pages.tar.gz" "$tap/Formula/paw-proxy.rb"
check "paw-proxy parses" ruby -c "$tap/Formula/paw-proxy.rb"

# 6. pr-nanny: formula and cask are separate packages; prerelease suffix ignored for ordering
fresh
run_case "pr-nanny formula rc.5 -> CalVer" 0 "$(printf '{"schema":"release-tools/tap-update/v1","app":"pr-nanny","kind":"formula","package":"pr-nanny","version":"2026.10.1","tag":"v2026.10.1","repo":"example-org/pr-nanny","assets":[{"os":"linux","arch":"amd64","kind":"tar.gz","url":"%s/pr-nanny/releases/download/v2026.10.1/pr-nanny-2026.10.1-linux-x64.tar.gz","sha256":"%s"}]}' "$U" $H1)"
check "pr-nanny cask untouched by formula update" cmp "$root/tests/fixtures/Casks/pr-nanny.rb" "$tap/Casks/pr-nanny.rb"

# 7. invalid input
fresh
run_case "missing assets exits 2" 2 '{"schema":"release-tools/tap-update/v1","app":"usb-boop","kind":"cask","package":"usb-boop","version":"2026.10.1","tag":"v2026.10.1","repo":"example-org/usb-boop"}'
run_case "empty assets exits 2" 2 '{"schema":"release-tools/tap-update/v1","app":"usb-boop","kind":"cask","package":"usb-boop","version":"2026.10.1","tag":"v2026.10.1","repo":"example-org/usb-boop","assets":[]}'
run_case "bad schema exits 2" 2 "$(cask_json 2026.10.1 $H1 | sed 's#tap-update/v1#tap-update/v0#')"
run_case "bad sha exits 2" 2 "$(cask_json 2026.10.1 nothex)"
run_case "wrong url prefix exits 2" 2 "$(cask_json 2026.10.1 $H1 | sed 's#github.com/example-org#example.com/example-org#')"
run_case "wrong tag in url exits 2" 2 "$(cask_json 2026.10.1 $H1 | sed 's#download/v2026.10.1/#download/v9.9.9/#')"
run_case "unknown package exits 2" 2 "$(cask_json 2026.10.1 $H1 | sed 's#"package":"usb-boop"#"package":"nope"#')"
run_case "package owned by another app exits 2" 2 "$(cask_json 2026.10.1 $H1 | sed 's#"app":"usb-boop"#"app":"paw-proxy"#')"
run_case "not json exits 2" 2 'not json'
run_case "incomplete scratchpad assets exits 2" 2 "$(scratch_json 2026.10.1 | sed '/darwin","arch":"arm64"/d')"
run_case "unused extra asset exits 2" 2 "$(cask_json 2026.10.1 $H1 | sed 's#}\]}#},{"os":"darwin","arch":"amd64","kind":"zip","url":"https://github.com/example-org/usb-boop/releases/download/v2026.10.1/extra.zip","sha256":"'$H2'"}]}#')"

# 8. cask with a linux asset
run_case "cask with linux asset exits 2" 2 "$(cask_json 2026.10.1 $H1 | sed 's#"os":"darwin"#"os":"linux"#')"
rm -f "$tap/update.json"
check "invalid input leaves tree unchanged" diff -r "$root/tests/fixtures" "$tap"

echo "passed: $pass, failed: $fail"
[ "$fail" -eq 0 ]
