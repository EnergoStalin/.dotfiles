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
  cargs=(
    "-s" "--tlsv1.3"
    "-Z" "--parallel-immediate"
    "--parallel-max" "50"
    "-w" '%{urlnum}$%{response_code}$%{http_version}@'
    "--max-time" "1"
  )

  args=()

  for url in ${urls[@]}; do
    IFS=' '
    for proto in $GGC_TEST_PROTO; do
      args=(${args[@]} ${cargs[@]})
      case "$proto" in
        "HTTPS")
          args=(${args[@]} "--http1.1" "--retry" "0")
          ;;
        "QUIC")
          args=(${args[@]} "--http3-only" "--retry" "0")
          ;;
        *)
          echo "Unsopported protocol $proto"
          return
          ;;
      esac
      args=(${args[@]} "https://$url" "-o" "/dev/null" "--next")
    done
  done
  unset 'args[${#args[@]}-1]'

  success_https=0
  success_quic=0
  IFS='@'
  for report in $(curl "${args[@]}" 2>/dev/null); do
    if [[ "$report" == "" ]]; then continue; fi
    IFS='$' read -r i code http_version <<< "$report"
    if [[ "$code" -eq "000" && ! -z "${urls[((i+1))]}" ]]; then
      echo "${urls[((i+1))]} UNAVALIABLE"
    else
      case "$http_version" in
        "1.1")
          ((success_https++))
          ;;
        "3")
          ((success_quic++))
          ;;
      esac
    fi
  done

  if [[ "$GGC_TEST_PROTO" =~ HTTPS ]]; then
    echo HTTPS Success/Total: $success_https/${#urls[@]}
  fi

  if [[ "$GGC_TEST_PROTO" =~ QUIC ]]; then
    echo QUIC Success/Total: $success_quic/${#urls[@]}
  fi
}