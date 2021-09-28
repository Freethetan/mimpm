#!/bin/bash

## One line help info
function alias_help(){
    echo "remove alias"
}

## Help doc for this alias
function alias_usage(){
   echo "USAGE: ${MIMIC_CALLER} ${MIMIC_ALIAS} alaias_name"
}

## Current alias worker
function alias_do(){
  echo "Removing ${MIMIC_CALLER} alias $1 from
  ${MIMIC_A_DIR}/"

  rm -rf "${MIMIC_A_DIR}/$1"
}



