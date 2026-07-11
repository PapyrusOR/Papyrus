#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
metadata_script="$script_dir/release_metadata.sh"

assert_contains() {
  local output="$1"
  local expected="$2"
  if [[ "$output" != *"$expected"* ]]; then
    echo "Expected output to contain: $expected" >&2
    echo "$output" >&2
    exit 1
  fi
}

stable="$(bash "$metadata_script" '1.2.3+7' 'v1.2.3' true false 42 abcdef123)"
assert_contains "$stable" 'is_prerelease=false'
assert_contains "$stable" 'build_name=1.2.3'
assert_contains "$stable" 'artifact_version=1.2.3'

prerelease="$(bash "$metadata_script" '1.2.3-rc.1+7' 'v1.2.3-rc.1' true false 43 abcdef123)"
assert_contains "$prerelease" 'is_prerelease=true'
assert_contains "$prerelease" 'build_name=1.2.3'
assert_contains "$prerelease" 'artifact_version=1.2.3-rc.1'

alpha="$(bash "$metadata_script" '1.2.3-alpha+7' 'v1.2.3-alpha' true false 44 abcdef123)"
assert_contains "$alpha" 'is_prerelease=true'

snapshot="$(bash "$metadata_script" '1.2.3+7' '' false false 45 abcdef123)"
assert_contains "$snapshot" 'tag_name=snapshot-abcdef1'

if bash "$metadata_script" '1.2.3+7' 'release-1.2.3' true false 46 abcdef123 >/dev/null 2>&1; then
  echo 'Invalid tag was accepted' >&2
  exit 1
fi

if bash "$metadata_script" '1.2.3+7' 'v1.2.4' true false 47 abcdef123 >/dev/null 2>&1; then
  echo 'Mismatched tag was accepted' >&2
  exit 1
fi

if bash "$metadata_script" '1.2.3-alpha+7' 'v1.2.3-alpha+7' true false 48 abcdef123 >/dev/null 2>&1; then
  echo 'A tag containing the pubspec build suffix was accepted' >&2
  exit 1
fi

echo 'release metadata tests passed'
