#!/usr/bin/env bash

VALUE_FILES=()
PARAMS=""

function appendParams() {
    if [ -z "$PARAMS" ]; then
      PARAMS="$1"
    else
      PARAMS="$PARAMS $1"
    fi
}

while (( "$#" )); do
  case "$1" in
    -f|--values)
      if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
        VALUE_FILES+=("$2")
        shift 2
      else
        echo "Error: flag needs an argument: $1" >&2
        exit 1
      fi
      ;;
    *)
      appendParams "$1"
      shift
      ;;
  esac
done

if ! command -v yq &> /dev/null; then
  echo "yq command is not installed"
  exit 1
fi

YQ_VERSION=$(yq --version)
if [[ ! $YQ_VERSION =~ ^.+3.+$ ]]; then
  echo "Only yq version 3.x is supported"
  exit 1
fi

set -- "${PARAMS[@]}"

if [ ${#VALUE_FILES[@]} -gt 0 ]; then
  yq m -x "${VALUE_FILES[*]}" | helm install "$@" --values -
else 
  helm install "$@"
fi
