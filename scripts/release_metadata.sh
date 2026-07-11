#!/usr/bin/env bash
set -euo pipefail

pubspec_version="${1:?pubspec version is required}"
tag_name="${2-}"
should_release="${3:?should_release is required}"
is_draft="${4:?is_draft is required}"
run_number="${5:?run number is required}"
commit_sha="${6:?commit SHA is required}"

pubspec_name="${pubspec_version%%+*}"
if [[ -z "$pubspec_name" ]]; then
  echo 'Unable to read a release version from pubspec.yaml' >&2
  exit 1
fi

tag_version="$pubspec_name"
if [[ "$should_release" == 'true' ]]; then
  if [[ ! "$tag_name" =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.-]+)?$ ]]; then
    echo "Release tag must match v<semver>: $tag_name" >&2
    exit 1
  fi

  tag_version="${tag_name#v}"
  if [[ "$tag_version" != "$pubspec_name" ]]; then
    echo "Release tag $tag_name does not match pubspec.yaml version $pubspec_version" >&2
    echo 'The tag must match the version before the optional +build suffix.' >&2
    exit 1
  fi
else
  tag_name="snapshot-${commit_sha:0:7}"
fi

is_prerelease=false
if [[ "$tag_version" == *-* ]]; then
  is_prerelease=true
fi

cat <<OUTPUT
should_release=$should_release
tag_name=$tag_name
is_draft=$is_draft
is_prerelease=$is_prerelease
build_name=${tag_version%%-*}
build_number=$run_number
artifact_version=$tag_version
OUTPUT
