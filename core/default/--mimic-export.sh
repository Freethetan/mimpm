#!/bin/bash

## One line help info
function alias_help(){
    echo "export alias"
}

## Help doc for this alias
function alias_usage(){
   echo "USAGE: ${MIMIC_CALLER} ${MIMIC_ALIAS} bin:alaias_name [bin:alias_name1[ bin:alias_name2 [bin:alias_nameN]]]
EXAMPLE:
   ${MIMIC_CALLER} ${MIMIC_ALIAS} git:sync git:cam npx:init npm
"
}

function is_mimic_bin_based(){
  local ALS_DIR=`dirname ${MIMIC_A_DIR}`;
  local mimic_name=`basename $1`
  local mimic_test_var=""
  if [ -f "${ALS_DIR}/${mimic_name}/bin/${mimic_name}" ];then
    mimic_test_var=`cat "${ALS_DIR}/${mimic_name}/bin/${mimic_name}" | grep 'MIMIC_BIN=' | sed 's/export //' | sed 's/MIMIC_BIN=//'`
    if `echo "$mimic_test_var" | grep -q '/'`; then
      return 0;
    fi
  fi
  return 1;
}

## Current alias worker
function alias_do(){
  local alss=( "$@" )
  local ALS_DIR=`dirname ${MIMIC_A_DIR}`;
  local ALS_BIN=""
  local ALS_NAME=""
  if [ -z "$1" ];then
    echo "Error: Alias name should be specified"
    exit 1;
  fi

  MIMIC_TMP_DIR=$(mktemp -d)
  #mkdir "${MIMIC_TMP_DIR}/${MIMIC_CALLER}"
  echo "Exporting alias(es)"
  for exp_als in "${alss[@]}"; do
    echo "---> ${exp_als}"
    if ! `echo "${exp_als}" | grep -q ':'`;then
      if [ -d "${ALS_DIR}/${exp_als}" ];then
        echo " |-> copying all ${exp_als} aliases"
        cp -rf "${ALS_DIR}/${exp_als}" "${MIMIC_TMP_DIR}"
        if is_mimic_bin_based "${ALS_DIR}/${exp_als}"; then
          # Binary for diffrent OSs are located in diffrent places
          rm -rf "${MIMIC_TMP_DIR}/${exp_als}/bin"
        fi
        echo " \`-> Done"
      else
        echo " |-> alias folder ${ALS_DIR}/${exp_als} does not exists"
        echo " \`-> Skipping"
      fi
    else
      ALS_BIN="`echo ${exp_als} | cut -d: -f1`"
      ALS_NAME="`echo ${exp_als} | cut -d: -f2`"

      if [ -f "${ALS_DIR}/${ALS_BIN}/${ALS_NAME}" ];then
        echo " |-> copying ${ALS_BIN} alias ${ALS_NAME}"
        mkdir -p ${MIMIC_TMP_DIR}/${ALS_BIN} 2>/dev/null
        cp -rf "${ALS_DIR}/${ALS_BIN}/${ALS_NAME}" "${MIMIC_TMP_DIR}/${ALS_BIN}"
        if ! is_mimic_bin_based "${ALS_DIR}/${ALS_BIN}"; then
           # It's a custom binary/shell copy it
           cp -rf "${ALS_DIR}/${ALS_BIN}/bin" "${MIMIC_TMP_DIR}/${ALS_BIN}"
        fi
        echo " \`-> Done"
      else
        echo " |-> alias ${ALS_NAME} does not exists in ${ALS_DIR}/${ALS_BIN}"
        echo " \`-> Skipping"
      fi
    fi
  done

  MIMIC_TARNAME="${MIMIC_CALLER}_Als_`date '+%Y_%m_%d'`.tar"
  local ARCH_CONTENT=`ls ${MIMIC_TMP_DIR}`
  #return;
  tar -Wcf "${MIMIC_TARNAME}" -C ${MIMIC_TMP_DIR} $ARCH_CONTENT
  #tree "${MIMIC_TMP_DIR}"
  rm -rf "${MIMIC_TMP_DIR}"
  echo -e "Your aliases are exported to `pwd`/${MIMIC_TARNAME}\nIt can be imported using  '`basename $0` --mimic-import ${MIMIC_TARNAME}'"
}
