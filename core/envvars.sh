#!/bin/bash

# Actual caller name. eg: git, netstat, ps
MIMIC_CALLER="$(basename $0)"
# Mimic editor
MIMIC_EDITOR=""

# Mimic-a root dir
MIMIC_ROOT_DIR="$(dirname $0)"
MIMIC_ROOT_DIR="$(dirname ${MIMIC_ROOT_DIR})"
MIMIC_ROOT_DIR=$(echo "${MIMIC_ROOT_DIR}" | sed "s|~|${HOME}|")

# Mimic-a library dir
MIMIC_CORE_DIR="${MIMIC_ROOT_DIR}/core"

# Mimic-a shared dir. Could contain functions that are shared across mimic libraries
MIMIC_SHRD_DIR="${MIMIC_ROOT_DIR}/shared"

# Mimic-a binary dir
MIMIC_B_DIR="${MIMIC_ROOT_DIR}/bin"

# Mimic-a aliases dir
MIMIC_A_PATH="${MIMIC_ROOT_DIR}/aliases"

# Mimic-a templates dir
MIMIC_TMPL_DIR="${MIMIC_CORE_DIR}/template"

# Mimic-a defaults dir
MIMIC_DFLT_DIR="${MIMIC_CORE_DIR}/default"

# Mimic-a current aliase dir
MIMIC_A_DIR="${MIMIC_A_PATH}/${MIMIC_CALLER}"

# Mimic-a current aliase name
MIMIC_ALIAS="${1}"

# Mimic editor definition file
MIMIC_EDITOR_FILE="$MIMIC_CORE_DIR/mimic-editor.txt"

# Mimic editor
MIMIC_EDITOR="$(cat $MIMIC_CORE_DIR/mimic-editor.txt | sed 's/\n//g' )"


#echo "MIMIC BIN: $MIMIC_BIN"
#echo "ENV CALL: $MIMIC_CALLER"
#echo "ENV ROOT: $MIMIC_ROOT_DIR"
#echo "ENV CORE: $MIMIC_CORE_DIR"
#echo "ENV TMPL: $MIMIC_TMPL_DIR"
#echo "ENV BIN:  $MIMIC_B_DIR"
#echo "ENV DFLT: $MIMIC_DFLT_DIR"
#echo "ENV CALS: $MIMIC_A_DIR"
#echo "ENV ALS:  $MIMIC_ALIAS"
#echo "ENV EDITOR:  $MIMIC_EDITOR"
