#!/bin/bash
## One line help info
function alias_help(){
    echo "Add/create mimic proxy alias"
}

## Help doc for this alias
function alias_usage(){
   echo "USAGE: ${MIMIC_CALLER} ${MIMIC_ALIAS}
    Create mimic proxy
    All call to ${MIMIC_CALLER} will be redirected to proxy script
    except there is defined alias handler
    E.g.: npm has defined 
       *    -> '--mimic-proxy'
       test -> '--mimic-add test'
       run  -> '--mimic-add run'
       npm run start will be routed to run alias
       npm run test will be routed to test alias
       npm run build will be routed to proxy alias
"
}

## Create alias worker
function alias_do(){

  mkdir ${MIMIC_A_DIR} 2>/dev/null 

  if [ -f "${MIMIC_A_DIR}/_proxy" ];then
    echo "Proxy script for ${MIMIC_BIN} already exists"
    return 0;
  fi
  echo "Creating _proxy in ${MIMIC_A_DIR} for ${MIMIC_BIN} "

  touch "${MIMIC_A_DIR}/_proxy"

  cat "${MIMIC_TMPL_DIR}/template.alias" | \
    sed "s|:MIMIC|:MIMIC=${MIMIC_CALLER}|" | \
    sed 's|:ALIAS|:ALIAS=_proxy|' \
    > "${MIMIC_A_DIR}/_proxy"

  . "${MIMIC_DFLT_DIR}/--mimic-edit.sh"

  alias_do "_proxy"
}


