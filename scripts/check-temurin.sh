#!/usr/bin/env bash
# Compares the shared workflows' Temurin pin with Adoptium's latest Temurin 25 build, and rewrites
# the pin when Adoptium has published a newer one.
#
# Every service's runtime is linked in CI from this pin, so the pin is the version production runs.
# Both boxes once ran 25.0.3 through two quarterly updates because nothing compared what they ran
# with what had been released; this is that comparison, run weekly. It proposes and never applies:
# the workflow opens the rewritten pin as a pull request, and the matching runtime-jdk-floor raise in
# build-conventions as another, and a person merges both and tags the release that relinks every
# service.
#
# Only Linux x64, because that is the platform CI links the images on. setup-java spells a four-part
# release with the patch level ahead of the build number: 25.0.5.1+2 is 25.0.5+1.2.
#
# Exit 0: the pin is current. 10: the pin was rewritten, and the release is on stdout's last line.
# 2: Adoptium could not be asked. 3: Adoptium's latest is older than the pin, which is a pulled
# release a person should read about rather than a pull request anybody should merge.
#
# Usage: scripts/check-temurin.sh, from the repository root.
set -euo pipefail

FEATURE=25
WORKFLOWS=.github/workflows

spec="$(grep -rhoE 'java-version: *"[^"]+"' "$WORKFLOWS" | sed -E 's/.*"([^"]+)"/\1/' | sort -u)"
[ "$(grep -c . <<<"$spec")" -eq 1 ] || { echo "the workflows pin more than one version: $spec" >&2; exit 1; }

# 25.0.5+1.2 -> 25.0.5.1+2, and 25.0.6+3 -> 25.0.6+3.
to_release() {
  local version="${1%%+*}" build="${1#*+}"
  case "$build" in
    *.*) printf '%s.%s+%s\n' "$version" "${build%%.*}" "${build#*.}" ;;
    *) printf '%s+%s\n' "$version" "$build" ;;
  esac
}
# The reverse, for writing the pin back.
to_spec() {
  local version="${1%%+*}" build="${1#*+}" major minor security patch
  IFS=. read -r major minor security patch <<<"$version"
  printf '%s.%s.%s+%s%s\n' "$major" "$minor" "$security" "${patch:+$patch.}" "$build"
}
# Padded to four parts so that sort -V orders 25.0.5+8 below 25.0.5.1+2.
version_key() {
  local version="${1%%+*}" build="${1#*+}"
  while [ "$(tr -cd . <<<"$version" | wc -c)" -lt 3 ]; do version="$version.0"; done
  printf '%s.%s\n' "$version" "$build"
}

pinned="$(to_release "$spec")"
url="https://api.adoptium.net/v3/assets/latest/$FEATURE/hotspot?os=linux&architecture=x64&image_type=jdk&vendor=eclipse"
latest="$(curl -fsS --max-time 30 --retry 3 --retry-all-errors "$url" | jq -er '.[0].release_name | ltrimstr("jdk-")')" || {
  echo "could not ask Adoptium for the latest Temurin $FEATURE" >&2
  exit 2
}

if [ "$latest" = "$pinned" ]; then
  echo "the shared workflows pin the latest Temurin $FEATURE: $pinned"
  exit 0
fi
if [ "$(printf '%s\n%s\n' "$(version_key "$pinned")" "$(version_key "$latest")" | sort -V | tail -1)" != "$(version_key "$latest")" ]; then
  echo "Adoptium's latest, $latest, is older than the pinned $pinned" >&2
  exit 3
fi

new_spec="$(to_spec "$latest")"
# shellcheck disable=SC2046
sed -i -E "s/java-version: *\"[^\"]*\"( # Temurin [^;]*;)?/java-version: \"$new_spec\" # Temurin $latest;/" \
  $(grep -rlE 'java-version: *"' "$WORKFLOWS")
echo "the shared workflows moved from $pinned to $latest"
echo "$latest"
exit 10
