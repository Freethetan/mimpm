#!/bin/bash


echo "Assuming this project is already located in correct folder
 - Otherwise move it to correct folder and rerun this file

  Add export to your .profile or .bashrc file to load aliases
"
mim_app_path=`dirname $0`
if ! [ "$1"=="--reinstall" ] && [ -x `which mimpm` ];then
  echo "mimp is already installed
  To force install use --reinstall key"
  exit;
fi
mim_app_exports="export PATH=$mim_app_path/bin:\$PATH"

echo "$mim_app_exports" > ~/.bashrc
export PATH=$mim_app_path/bin:$PATH

mimpm --set-editor
