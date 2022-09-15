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
  ./bin/phpunit \
    --configuration "$TOOLS_PATH"/phpunit/phpunit.xml.dist \
    --exclude-group learning \
    --colors=always \
    --testdox \
    --verbose \
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