#!/usr/bin/env sh
set -euo pipefail

cat <<EOF > "$(git rev-parse --git-dir)/hooks/update"
#!/usr/bin/env sh
set -euo pipefail

refname="\$1"
newrev="\$3"

zero=\$(git hash-object --stdin </dev/null | tr '[0-9a-f]' '0')

if [[ "\$refname" =~ refs/heads/* && "\$newrev" == "\$zero" ]]; then
	BRANCH="\${refname##*\/}"
	GLAB_FILTER="--branch '\$BRANCH'"
	GH_FILTER="--branch '\$BRANCH'"
	sh "$(dirname "$(realpath "$0")")/delete-workflow-runs.sh"
fi
EOF