#! /bin/bash

create_badge() {

  local BADGE_NAME="$1"
  local STATUS="$2"
  local TOOL_NAME="$3"
  local COLOR=$(if [ "$STATUS" == "passed" ]; then echo "green"; else echo "red"; fi)

  rm -f "public/$TOOL_NAME.svg"
  rm -f "public/$TOOL_NAME.png"

  ./vendor/bin/poser \
    "$BADGE_NAME" \
    "$STATUS" \
    "$COLOR" \
    -p "public/$TOOL_NAME.svg" \
    -s plastic \
    &>/dev/null

  inkscape --export-png="public/$TOOL_NAME.png" \
    --export-dpi=200 \
    --export-background-opacity=0 \
    --without-gui "public/$TOOL_NAME.svg" \
    &>/dev/null

  rm -f "public/$TOOL_NAME.svg"
}

coverage_badge() {

  vendor/bin/php-coverage-badger \
    .coverage/coverage-clover.xml \
    .coverage/coverage-badge.svg

  inkscape \
    --export-png=public/coverage-badge.png \
    --export-dpi=200 \
    --export-background-opacity=0 \
    --without-gui .coverage/coverage-badge.svg &>/dev/null
}