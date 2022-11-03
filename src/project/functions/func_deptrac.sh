#! /bin/bash

DEPTRAC_CONFIG_FILES="${TOOLS_PATH}/deptrac/*"

deptrac_image() {

  local DEPFILE=$1
  local IMG=$(basename "${DEPFILE%.yaml}".png)

  ./vendor/bin/deptrac analyse \
    --config-file "$DEPFILE" \
    --no-cache \
    --formatter=graphviz-image \
    --output=./doc/deptrac/"$IMG"
}

deptrac_table() {

  local DEPFILE=$1
  local OPTIONS=$2

  ./vendor/bin/deptrac analyse \
    --config-file "$DEPFILE" \
    --no-cache \
    --formatter=table $OPTIONS
}

deptrac_table_all() {

  local OPTIONS=${1:-""}

  for f in $DEPTRAC_CONFIG_FILES; do
    echo "$f"
    deptrac_table "$f" $OPTIONS

    local STATUS=$?

    if [[ "$STATUS" -ne 0 ]]; then
      return 1 #false
    fi
  done
}