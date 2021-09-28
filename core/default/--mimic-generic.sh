#!/bin/bash

## One line help info
function alias_help(){
  echo "alias $MIMIC_ALIAS does non have defined nothing"
}

## Help doc for this alias
function alias_usage(){
   echo "SOLUTION: Recreate current mimic alias
   delete by running: ${MIMIC_CALLER} --mimic-remove ${MIMIC_ALIAS}
   create by running: ${MIMIC_CALLER} --mimic-add ${MIMIC_ALIAS}
   "
}


## Current alias worker
function alias_do(){
  alias_help
  alias_usage
  return 1;
}
