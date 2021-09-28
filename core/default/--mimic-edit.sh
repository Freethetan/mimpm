#!/bin/bash

## One line help info
function alias_help(){
    echo "Default mimic edit handler"
}

## Help doc for this alias
function alias_usage(){
   echo "USAGE: ${MIMIC_CALLER} ${MIMIC_ALIAS} [alias name]"
}


## Current alias worker
function alias_do(){
  if [ -z "$MIMIC_EDITOR" ];then
    while true
    do
      read_user_arg "MIMIC_EDITOR" "Enter preferred editor"
      if [ -x "$(which ${MIMIC_EDITOR})" ];then
        echo $(which ${MIMIC_EDITOR}) > "$MIMIC_EDITOR_FILE"
        break;
      fi
      echo "$MIMIC_EDITOR is not a valid executable"
    done
  fi
  mkdir -p ${MIMIC_A_DIR} > /dev/null
  ${MIMIC_EDITOR} "${MIMIC_A_DIR}/$1" 3>&1 1>&2 2>&3
  echo -e "Alias saved as\n\t${MIMIC_A_DIR}/$1"
}
