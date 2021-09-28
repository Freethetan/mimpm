#!/bin/bash

## One line help info
function alias_help(){
    echo "import aliases from tar"
}

## Help doc for this alias
function alias_usage(){
   echo "USAGE: ${MIMIC_CALLER} ${MIMIC_ALIAS} alaias_arcquive.tar"
}

function is_mimic_notbin_based(){
  local ALS_DIR=`dirname ${MIMIC_A_DIR}`;
  local mimic_name=`basename $1`
  local mimic_test_var=""
  if [ -f "${ALS_DIR}/${mimic_name}/bin/${mimic_name}" ];then
    mimic_test_var=`cat "${ALS_DIR}/${mimic_name}/bin/${mimic_name}" | grep 'MIMIC_BIN=' | sed 's/export //' | sed 's/MIMIC_BIN=//'`
    if ! [ -z "$mimic_test_var" ] && `echo "$mimic_test_var" | grep -q '/'`; then
      return 0;
    fi
  fi
  return 1;
}

## Current alias worker
function alias_do(){
  local arch_list="`tar -tf $1 | cut -d/ -f1 | uniq`"
  if [ -z "$1" ] ||  `echo "$1" | egrep -q '^[-]*[h|help]...$'`;then
    alias_help
    alias_usage
    return
  elif [ -f "$1" ];then
    echo "Importing aliases from $1"
    tar -xf "$1" -C ${MIMIC_A_PATH}

    for alias_bin in ${arch_list};
    do
      echo " - $alias_bin -> IMPORTED."
      if ! is_mimic_notbin_based "$alias_bin";then
        if `which $alias_bin > /dev/null`; then
          mimpm --mimic-add $alias_bin > /dev/null
        else
          echo "   * Binary for mimic '$alias_bin' IS NOT INSALLED
     Please install $alias_bin binaries on your system first
     and then run this import again"
        fi
      fi
    done

  else
    alias_help
    echo "ERROR: $1 is not a file"
    alias_usage
  fi


}
