function host() {
  for fp in "$@"; do
    cat $fp | tr '\n' ' '
  done
}

function ggc_from_har() {
  jq -r '.. | objects | .request.url' "$@" | grep -e 'googlevideo' | sed -e 's|https://||gm' -e 's|/.*$||gm' | sort | uniq
}

function ggc_wireshark_filter_from_har() {
  echo host $(ggc_from_har "$@" | tr '\n' ' ' | sed -e 's/ / || host /g') | sed -e 's/ || host$//m'
}

function ggc_curl_test() {
  IFS=$'\n' urls=($(cat $@))
  args=(
    "-s" "--tlsv1.3"
    "-Z" "--parallel-immediate"
    "--parallel-max" "200"
    "-w" '%{urlnum}$%{response_code}@'
    "--retry" "2"
    "--max-time" "2"
  )

  for url in ${urls[@]}; do
    args=(${args[@]} "https://$url" "-o" "/dev/null")
  done

  success=0
  IFS='@'
  for report in $(curl "${args[@]}" 2>/dev/null); do
    IFS='$' read -r i code <<< "$report"
    if [[ "$code" -eq "000" ]]; then
      echo "${urls[((i+1))]} UNAVALIABLE"
    else
      ((success++))
    fi
  done

  echo Success/Total: $success/${#urls[@]}
}
