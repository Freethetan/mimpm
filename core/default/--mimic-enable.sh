#!/bin/bash

#:mimpm
#:--mimic-enable

# Available environment variables
# MIMIC_ROOT_DIR     Application root folder [~/.mimpm]
# MIMIC_A_PATH       Aliases root dir like aliases/
# MIMIC_B_DIR        Folder that contains mimic binaries [git, ls, npx, etc.]
# MIMIC_A_DIR        Folder that contains current mimic aliases. eg: --log, --start, reload
# MIMIC_SHRD_DIR     Folder that contains shared functions that are sourced into alias environment
# MIMIC_CALLER       Called executable name(mimic) like git / netstat / ifconfig
# MIMIC_BIN          Original executable path /usr/bin/git
# MIMIC_ALIAS        Called alias name like: git --log  --log is an alias

## One line help info
function alias_help(){
    echo "Enable mimic interceptor"
}

## Multiline help doc for this alias
function alias_usage(){
   echo "USAGE: mimpm --mimic-enable <mimic>
   e.g: mimpm --mimic-enable git - enable git interceptor"
}

## Alias worker
#  If alias is prefixed with ! ( git ! log )
#  will be executed with original binary as /usr/bin/git log
##
function alias_do(){
  local newMimicBinPath="${MIMIC_A_PATH}/${1}/bin"
  local mimicName="$2"
  echo "Enabling mimic ${1} as $mimicName"

  if [ -f "${newMimicBinPath}/$1" ];then
      if [ -f ${MIMIC_B_DIR}/$1 ];then
        echo "Mimic interceptor for $1 already enabled"
      else
        chmod +x ${newMimicBinPath}/${1}
        ln -s "${newMimicBinPath}/${1}" "${MIMIC_B_DIR}/$mimicName"
        echo "Done."
      fi
  else
    echo "Mimic interceptor for $1 does not exists"
  fi
  date
}
