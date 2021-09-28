#!/bin/bash

## One line help info
function alias_help(){
    echo "List assigned mimic aliases"
}

## Help doc for this alias
function alias_usage(){
   echo "USAGE: ${MIMIC_CALLER} ${MIMIC_ALIAS} [arg1 [arg2 [...[argN]]]]"
}

## Current alias worker
function alias_do(){
  for als in `find $MIMIC_A_DIR -maxdepth 1 -type f`;
  do
    . "${als}"
    echo "  `basename $als`  `alias_help`"
  done
}
