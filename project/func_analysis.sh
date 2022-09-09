#! /bin/bash

check_deps_vulnerabilities() {
  composer audit

  local STATUS=$?

  if [[ "$STATUS" -eq 0 ]]; then
    echo -e "\e[42mDependency vulnerability check is OK\e[m"
    create_badge "deps vulnerability check" passed deps_check
    return 0 # true
  fi
}

infection() {

  ./vendor/bin/infection \
    run \
    --threads=4 \
    --configuration="$TOOLS_PATH"/infection/infection.json \
    --verbose \
    --debug \
    "$@"
}

psalm() {
  ./vendor/bin/psalm -c "$TOOLS_PATH"/psalm/psalm.xml --show-info=true --no-cache "$@"

  local PSALM_STATUS=$?

  if [[ "$PSALM_STATUS" -eq 0 ]]; then
    create_badge "static analysis" passed psalm

    if [[ "$@" == *"--taint-analysis"* ]]; then
      create_badge "taint analysis" passed psalm_taint
    fi
  fi

  return $PSALM_STATUS
}

coding_standard_fix() {

  #--stop-on-violation \

  ./vendor/bin/php-cs-fixer \
    fix \
    --verbose \
    --show-progress=dots \
    --cache-file="$TOOLS_PATH"/php-cs-fixer/.php-cs-fixer.cache \
    --config="$TOOLS_PATH"/php-cs-fixer/.php-cs-fixer.dist.php "$@"

  #  STATUS=$?
  #
  #  return $STATUS
}