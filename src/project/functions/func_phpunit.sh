#! /bin/bash

coverage() {
  export XDEBUG_MODE=coverage

  phpunit --coverage-text \
    --coverage-clover=.coverage/coverage-clover.xml \
    --coverage-html .coverage/html

  local TEST_STATUS=$?

  export XDEBUG_MODE=off

  if [[ "$INTERNAL_BADGE_CREATION" == true ]]; then
    if [[ "$TEST_STATUS" -eq 0 ]]; then
      create_badge test passed phpunit
    else
      create_badge test failed phpunit
    fi

    coverage_badge
  fi

  return $TEST_STATUS
}

phpunit() {

  local PHPUNIT_BIN

  if [ -f "./bin/phpunit" ]; then
    PHPUNIT_BIN=./bin/phpunit
  elif [ -f "./vendor/bin/phpunit" ]; then
    PHPUNIT_BIN=./vendor/bin/phpunit
  elif [ -f "./vendor/bin/simple-phpunit" ]; then
    PHPUNIT_BIN=./vendor/bin/simple-phpunit
  fi

  if [ -z "$PHPUNIT_BIN" ]; then
    echo "PHPUnit executable does not found";
    exit 1;
  fi

  $PHPUNIT_BIN \
    --configuration "$TOOLS_PATH"/phpunit/phpunit.xml.dist \
    --exclude-group learning \
    --colors=always \
    "$@"

  local TEST_STATUS=$?

  if [[ "$INTERNAL_BADGE_CREATION" == true ]]; then
    if  [[ "$TEST_STATUS" -eq 0 ]]; then
      create_badge test passed phpunit
    else
      create_badge test failed phpunit
    fi
  fi

  return $TEST_STATUS
}