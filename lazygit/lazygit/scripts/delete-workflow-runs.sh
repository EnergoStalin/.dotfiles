#!/usr/bin/env sh
set -euo pipefail

_gh() {
	gh run list \
		$GH_FILTERS \
		--json databaseId --jq '.[].databaseId' \
	| xargs -P 8 -rL 1 gh run delete
}

_glab() {
	glab ci list \
		$GLAB_FILTERS \
		--output json \
	| jq -r '.[].id' \
	| xargs -P 8 -rL 1 glab ci delete
}

source "$(dirname "$(realpath "$0")")/call.sh"