#!/bin/bash

#:MIMIC
#:ALIAS

# Available environment variables
# MIMIC_ROOT_DIR     Application root folder [~/.mimpm]
# MIMIC_B_DIR        Folder that contains mimic binaries
# MIMIC_A_DIR        Folder that contains current mimic aliases like eg: --log, --start, reload
# MIMIC_SHRD_DIR     Folder that contains shared functions that are sourced into alias environment
# MIMIC_CALLER       Called executable name(mimic) like git / netstat / ifconfig
# MIMIC_BIN          Original executable path /usr/bin/git
# MIMIC_ALIAS        Called alias name like: git --log  --log is an alias

## One line help info
function alias_help(){
    echo "alias handler for ${MIMIC_BIN} ${1}"
}

## Multiline help doc for this alias
function alias_usage(){
   echo "USAGE: ${MIMIC_CALLER} ${1} [arg1 [arg2 [...[argN]]]]"
}

## Alias worker
#  If alias is prefixed with ! ( git ! log )
#  will be executed with original binary as /usr/bin/git log
##
function alias_do(){
  # Add/Modify/Preprocess/Postprocess parameters or functionality
  echo "Disabling $1 mimic"
  if [ -f  "${MIMIC_B_DIR}/$1" ];then
    rm -rf ${MIMIC_B_DIR}/$1
    echo "Done"
  fi
  date
}
