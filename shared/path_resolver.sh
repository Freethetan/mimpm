#!/bin/bash


function resolve_path(){
  local src_pth=""

  if [ -f "$1" ] ;then
    src_pth=$(readlink L "$1");
  elif [ -d "$1" ] ;then
    src_pth=$(pwd -P "$1");
  fi

  if ! [ -z "$src_pth" ] && ! [ -f "$src_pth" ] ;then
    src_pth="`dirname $1`/$src_pth"
  fi
#echo "-p_res-> $src_pth" >&2
  [ -z "$src_pth" ] && echo "$1" || echo "$src_pth"
}
