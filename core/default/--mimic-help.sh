#!/bin/bash

## One line help info
function alias_help(){
    echo "Define your mimic alias help"
}

## Help doc for this alias
function alias_usage(){
   echo "USAGE: ${MIMIC_CALLER} --mimic-help <alias_name>
   Man for <mimic_name>"
}


## Current alias worker
function alias_do(){
  if [ -f "${MIMIC_A_DIR}/$1" ];then
    . "${MIMIC_A_DIR}/$1"
  elif [ -f "${MIMIC_DFLT_DIR}/$1.sh" ];then
    . "${MIMIC_DFLT_DIR}/$1.sh"
  fi
  alias_help "$1"
  alias_usage "$1"
}
