#!/usr/bin/env bash

check_code_style() {

  # Formattazione del codice con PHP CS Fixer
  make coding-standard-check-staged
  STATUS=$?

  if [[ "$STATUS" -eq 0 ]]; then
    echo ""
    echo -e "\e[42mCode style is OK\e[m"
    return 0 # true
  fi

  while true; do
    echo -e "\e[41mInvalid code style\e[m"
    read -p $'\e[31mDo you really want to commit ignoring code style warnings? y/n/f[Fix] \e[0m: ' yn </dev/tty
    case $yn in
    [Yy]*)
      echo ""
      echo "Please consider fixing code style"
      return 0
      ;;
    [Nn]*)
      echo "Run 'make coding-standard-fix-staged' to fix"
      return 1
      ;;
    [Ff]*)
      make coding-standard-fix-staged
      return $?
      ;;
    *) echo "Please answer y, n or f." ;;
    esac
  done
}

check_psalm() {

  # Analisi statica del codice con Psalm
  make psalm
  STATUS=$?

  if [[ "$STATUS" -eq 0 ]]; then
    echo -e "\e[42mPHP Static Analysis is OK\e[m"
    return 0 # true
  fi

  while true; do
    read -p $'\e[31mDo you really want to commit ignoring psalm errors? y/n \e[0m: ' yn </dev/tty
    case $yn in
    [Yy]*)
      echo ""
      echo "Please consider fixing psalm errors"
      return 0
      ;;
    [Nn]*) return 1 ;; # No commit
    *) echo "Please answer y or n." ;;
    esac
  done
}

check_psalm_taint_analysis() {
  # Analisi statica del codice con Psalm
  make psalm-taint
  STATUS=$?

  if [[ "$STATUS" -eq 0 ]]; then
    echo -e "\e[42mPHP Taint analysis Analysis is OK\e[m"
    return 0 # true
  fi

  while true; do
    read -p $'\e[31mDo you really want to commit ignoring taint analysis errors? y/n \e[0m: ' yn </dev/tty
    case $yn in
    [Yy]*)
      echo ""
      echo "Please consider fixing taint analysis errors"
      return 0
      ;;
    [Nn]*) return 1 ;; # No commit
    *) echo "Please answer y or n." ;;
    esac
  done
}

check_phpunit() {

  # Esecuzione dei test con phpunit
  make phpunit
  STATUS=$?

  if [[ "$STATUS" -eq 0 ]]; then
    echo -e "\e[42mPHP Unit Tests Suite is OK\e[m"
    return 0 # true
  fi

  echo "Pay attention! Unit Tests are broken."
  return 1
}

check_dependencies_vulnerabilities() {

  make check-deps-vulnerabilities

  STATUS=$?

  if [[ "$STATUS" -gt 0 ]]; then
    echo "Dependency vulnerability problem"
    return 1 # true
  fi

  return 0
}

check_deptrac() {

  make deptrac-table-all ARG="--quiet"

  STATUS=$?

  if [[ "$STATUS" -eq 0 ]]; then
    echo ""
    echo -e "\e[42mDeptrac is OK\e[m"
  else
    echo -e "\e[31m Deptrac if failed\e[m"
    return 1
  fi

  return 0 # true
}