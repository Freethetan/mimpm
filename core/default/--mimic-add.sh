#!/bin/bash
echo "Sourced default mimic-add "
## One line help info
function alias_help(){
    echo "Add/create mimic alias"
}

## Help doc for this alias
function alias_usage(){
   echo "USAGE: ${MIMIC_CALLER} ${MIMIC_ALIAS} [name]
    Create new mimic or alias for binary
    If called from mimic-a will create new mimic for binary
    If called from binary[eg: git --mimic-add name ] will create new alias
"
}

## Create alias worker
function alias_do(){
  local newAlias="$1"
  if [ -z "${newAlias}" ];then
    echo "Alias name can not be empty"
    return 0;
  fi

  mkdir -p "${MIMIC_A_DIR}/bin" 2>/dev/null 

  if [ -f "${MIMIC_A_DIR}/${newAlais}" ];then
    echo "Alias ${newAlias} for ${MIMIC_BIN} already exists"
    return 0;
  fi
  echo "Creating new alias ${newAlias} in ${MIMIC_A_DIR} for ${MIMIC_BIN} "


  touch "${MIMIC_A_DIR}/${newAlais}"

  cat "${MIMIC_TMPL_DIR}/template.alias" | \
    sed "s|:MIMIC|:MIMIC=${MIMIC_CALLER}|" | \
    sed "s|:ALIAS|:ALIAS=${newAlias}|" \
    > "${MIMIC_A_DIR}/${newAlias}"

  . "${MIMIC_DFLT_DIR}/--mimic-edit.sh"

  echo "${MIMIC_A_DIR}/${newAlias}"
  alias_do "${newAlias}"
}
