#! /bin/bash

check_deps_vulnerabilities() {
  composer audit

  local STATUS=$?

  if [[ "$STATUS" -eq 0 ]]; then
    echo -e "\e[42mDependency vulnerability check is OK\e[m"

    if [[ "$INTERNAL_BADGE_CREATION" == true ]]; then
      create_badge "deps vulnerability check" passed deps_check
    fi

  else
    if [[ "$INTERNAL_BADGE_CREATION" == true ]]; then
      create_badge "deps vulnerability check" failed deps_check
    fi
  fi

  return $STATUS
}

infection() {
#--threads=4 \
  ./vendor/bin/infection \
    run \
    -j$(nproc) \
    --configuration="$TOOLS_PATH"/infection/infection.json \
    --verbose \
    --debug \
    "$@"
}

psalm() {
  ./vendor/bin/psalm -c "$TOOLS_PATH"/psalm/psalm.xml --show-info=true --no-cache "$@"

  local PSALM_STATUS=$?

  if [[ "$INTERNAL_BADGE_CREATION" == true ]]; then

    if [[ "$@" == *"--taint-analysis"* ]]; then

      if [[ "$PSALM_STATUS" -eq 0 ]]; then
        create_badge "taint analysis" passed psalm_taint
      else
        create_badge "taint analysis" failed psalm_taint
      fi

    else

      if [[ "$PSALM_STATUS" -eq 0 ]]; then
        create_badge "static analysis" passed psalm
      else
        create_badge "static analysis" failed psalm
      fi
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