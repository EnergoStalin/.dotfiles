#!/usr/bin/env sh
set -euo pipefail

ORIGIN="$(git remote get-url origin)"
if
	[[ "$ORIGIN" == *github* ]]
then
	command -v gh > /dev/null || { echo "Command gh not found"; exit 1; }
	gh auth status &> /dev/null || { echo "Unauthenticated"; exit 1; }

	_gh
elif
	[[ "$ORIGIN" == *gitlab* ]]
then
	command -v glab > /dev/null || { echo "Command glab not found"; exit 1; }
	glab auth status &> /dev/null || { echo "Unauthenticated"; exit 1; }

	_glab
fi