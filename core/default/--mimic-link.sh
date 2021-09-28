#!/bin/bash

## One line help info
function alias_help(){
  echo "link alias name (ln -s longalias shortalias)"
}

## Help doc for this alias
function alias_usage(){
   echo "USAGE: ${MIMIC_CALLER} ${MIMIC_ALIAS} existing_alias new_alias"
}

## Current alias worker
function alias_do(){
  if ! [ -f "${MIMIC_A_DIR}/$1" ];then
    echo "Error: unable to create link
    File ${MIMIC_A_DIR}/$1 for link does not exists"
    return
  fi
  echo "Creating link for ${MIMIC_CALLER} alias $1 as $2 in
  ${MIMIC_A_DIR}/"

  ln -s "${MIMIC_A_DIR}/$1" "${MIMIC_A_DIR}/$2"
}



