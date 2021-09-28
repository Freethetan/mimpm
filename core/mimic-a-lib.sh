#!/bin/bash

# Load env vars
. "$(dirname $0)/../core/envvars.sh"

# Load shared functions
for shrdFl in `find "${MIMIC_SHRD_DIR}" -type f -name "*.sh"`
do
  [ -f "${shrdFl}" ] && . ${shrdFl}
done

#----------------------------------------------------
# Load generic mimic
. "${MIMIC_DFLT_DIR}/--mimic-generic.sh"
#---------------------------------------------------

if [ "${MIMIC_ALIAS}" == "!" ];then
  shift
  #echo "Direct call"
  CALLER_NAME="${MIMIC_BIN}"
  . ${MIMIC_CORE_DIR}/mimic-caller.sh
  return $?
elif [ -f "${MIMIC_A_DIR}/${MIMIC_ALIAS}" ];then
  shift
  #echo "Source mimic alias"
  als_file=$(resolve_path ${MIMIC_A_DIR}/${MIMIC_ALIAS})
  . "$als_file"
  MIMIC_ALIAS="$(basename $als_file)"
  CALLER_NAME="alias_do"
  . ${MIMIC_CORE_DIR}/mimic-caller.sh
  return $?
elif [ -f "${MIMIC_DFLT_DIR}/${MIMIC_ALIAS}.sh" ];then
  shift
  #echo "Source default alias"
  . ${MIMIC_DFLT_DIR}/${MIMIC_ALIAS}.sh
  als_file="$(resolve_path ${MIMIC_DFLT_DIR}/${MIMIC_ALIAS}.sh)"
  . "$als_file"
  MIMIC_ALIAS="$(basename $als_file)"
  CALLER_NAME="alias_do"
  . ${MIMIC_CORE_DIR}/mimic-caller.sh
  return $?
elif [ -f "${MIMIC_A_DIR}/_proxy" ];then
  #echo "Source mimic proxy alias"
  als_file=$(resolve_path ${MIMIC_A_DIR}/_proxy)
  . "$als_file"

  MIMIC_ALIAS="$(basename $1)"
  shift
  CALLER_NAME="alias_do"
  . ${MIMIC_CORE_DIR}/mimic-caller.sh
  return $?
elif ! [ -z "${MIMIC_BIN}" ];then
  #echo "Call empty original bin ${MIMIC_BIN} $*"
  CALLER_NAME="${MIMIC_BIN}"
  . ${MIMIC_CORE_DIR}/mimic-caller.sh
  return $?
fi

#echo "${MIMIC_DFLT_DIR}/${MIMIC_ALIAS}.sh"
#[ -f "${MIMIC_DFLT_DIR}/${MIMIC_ALIAS}.sh" ] && echo "EXISTS"

echo "Something went wrong while processing alias ${MIMIC_CALLER} ${MIMIC_ALIAS}"
echo "Check alias contents by hitting"
echo "${MIMIC_CALLER} --mimic-edit ${MIMIC_ALIAS}"

###alias_help $*
###alias_do $*
return 22

#compgen -f help_line
