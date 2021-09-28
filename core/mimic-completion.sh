#!/bin/bash

#https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion-Builtins.html

function _mimic_completion () {
  local m_als_d="/Users/$USER/.mimic-a/aliases"
  local cur
  local mimic_bin="$1"
  local prev_param="$2"
  local optsAvail

  COMPREPLY=()   # Array variable storing the possible completions.
  cur=${COMP_WORDS[COMP_CWORD]}

  if [ -d "${m_als_d}/${mimic_bin}" ];then
    optsAvail="$(ls -m ${m_als_d}/${mimic_bin} 2>/dev/null )"
  #else
  #  optsAvail="$(ls -m .)"
  fi
  #echo 1
  #echo 2
  #echo 3
  #echo $optsAvail;
  #echo $prev_param;
  IFS=","
  COMPREPLY=( $( compgen -W "$optsAvail" -- $cur ) )
  #case "$cur" in
  #  *)
  #COMPREPLY=( $( compgen -W '-a -d -f -l -t -h --aoption --debug --file --log --test --help --' $cur ) )
#   Generate the completion matches and load them into $COMPREPLY array.
#   xx) May add more cases here.
#   yy)
#   zz)
  #esac
  #return 1
  return 0
}

#complete -F _UseGetOpt-2 -o filenames ./UseGetOpt-2.sh
#        ^^ ^^^^^^^^^^^^  Invokes the function _UseGetOpt-2.

#complete -o filenames -o default -o nospace -C _mimic_completion git
complete -F _mimic_completion git


