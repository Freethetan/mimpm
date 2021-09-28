#!/bin/bash
### BEGIN INFO
# Description: Read data from stdin [PIPE]
# Provides:	read_user_ar
# Arg[1]: var_name
# Return: status [1-data read; 0-no data provided]
### END INFO
read_stdin_pipe() {
    local varname="$1"
    export $varname="$(cat -)"
    if [ -z "$varname" ];then
        return 0;
    fi
    return 1;
}

### BEGIN INFO
# Description:	Prompt user to insert variable value
# Provides:	read_user_arg
# Arg[1]: var_name | if contains value it will be used as a default value
# Arg[2]: Message to ask
# Arg[3]: Default value if no input
### END INFO
function read_user_arg(){ #message [default]
    local varname="$1"
    local message="$2"
    local default="${3:-${!varname}}"
    local varval=""
    local retval=0

    if [ -z "$default" ] || [ "$default" == "" ];then
        while [ -z "$varval" ];
        do
            echo -ne "${message}:"
            read varval
        done
    else
        echo -ne "${message}:"
        read varval
        if ! [ -z "$varval" ];then
            retval=1;
        fi
    fi
    varval=`[ -z "$varval" ] && echo "$default" || echo "$varval"`
    export $varname="${varval}"
    return $retval;
}

### BEGIN INFO
# Description:	Prompt user to insert text
# Provides:	read_user_text
# Arg[1]: var_name
# Arg[2]: Message to ask
### END INFO
function read_user_text(){
    local varname="$1"
    local message="$2"
    local text=""
    local empt_trigger=0;

    echo "$message:"
    echo "End your text with double empty lines"

    while IFS= read -r line; do
        if [ -z "$line" ];then
            empt_trigger=`expr $empt_trigger + 1`
        else
            text="${text}${line}\n"
            empt_trigger=0;
        fi
        if [ $empt_trigger -gt 1 ];then
            break
        fi

    done < /dev/stdin
    export $varname="${text}"
}
### BEGIN INFO
# Description:	Prompt user to insert variable value
# Provides:	user_confirm
# Arg[1]: Message to confirm (Do you want to proceed?)
# Arg[2]: Default value if no input [0|Nn|Oo]
### END INFO
function user_confirm(){ #message [default]
  local msg="$1"
  local dflt="$2"
  if [ -z "$dflt" ] || [[ "$dflt" =~ /0Nn/ ]] ;then
    dflt="n"
  else
    dflt="y"
  fi
  USR_CONFIRM_ANSW=""
  [[ "$dflt" =~ "y" ]] &&  msg="$msg[Y/n]" || msg="$msg[y/N]"

  read_user_arg "USR_CONFIRM_ANSW" "$msg" "$dflt"
  ##echo "USR: $USR_CONFIRM_ANSW"
  [[ "$USR_CONFIRM_ANSW" =~ [1Yy] ]] && return 0 || return 1;
}
