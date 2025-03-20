#!/bin/env sh

_gh() {
	gh run list \
		$GH_FILTERS \
		--json databaseId --jq '.[].databaseId' \
	| xargs -n 1 gh run delete || true
}

_glab() {
	glab ci list \
		$GLAB_FILTERS \
		--json databaseId --jq '.[].databaseId' \
	| xargs -n 1 glab ci delete || true
}

source "$(dirname "$(realpath "$0")")/call.sh"