#!/bin/bash

#Function for -h flag OR invalid option
usage(){
  echo "proc_info.sh - An easy cli tool for PID inspection"
  echo
  echo "Usage:"
  echo "proc_info.sh PID [-e|-u|-f|-c|-h]"
  echo
  echo "Options:             Arguments:"
  echo
  echo "-e                   Show environment variable for the process"
  echo "-u                   Show owner of the process"
  echo "-c                   Show command that started the process"
  echo "-f                   Show opened files by the process"
  echo "-h                   Show this help"
  exit 0
}

info(){
  pid=$(echo $1 | sed -e 's/^[^=]*=//g')
  who_folder=$(sudo lsof -w -p ${pid} | grep cwd | awk '{ print $9 }')
  who_user=$(sudo lsof -w -p ${pid} | grep cwd | awk '{ print $3 }')
  triggered_by_cmd=$(tr -d '\0' < /proc/$pid/cmdline)
  echo "$pid Process"
  echo "Working directory on $who_folder"
  echo "Ran by user ${who_user}"
  echo "Triggered by command ${triggered_by_cmd}"
}

#Function for -u flag
get_owner(){
  pid=$1
  user_id=$(cat /proc/$pid/status | grep Uid | awk '{ print $2 }')
  #https://unix.stackexchange.com/a/36582/468165 - Get user by Id
  getent passwd "$user_id" | cut -d: -f1
}

#Function for -c flag
get_command(){
  pid=$1
  cat /proc/$pid/comm
}

#Function for -e flag
get_env_vars(){
  pid=$1
  cat /proc/$pid/environ | tr '\0' '\n'
}

#Function for -f flag
get_opened_files(){
  pid=$1
  ls -l /proc/$pid/fd | less | awk '{ print $11 }'
}

while test $# -gt 0; do
  case "$1" in
    -h) usage ;;
    -u)
      shift
      if test $# -gt 0; then
        get_owner $1
      else
        echo "no process specified"
        exit 1
      fi
      shift
      ;;
    -c)
      shift
      if test $# -gt 0; then
        get_command $1
      else
        echo "no process specified"
        exit 1
      fi
      shift
      ;;
    -e)
      shift
      if test $# -gt 0; then
        get_env_vars $1
      else
        echo "no process specified"
        exit 1
      fi
      shift
      ;;
    -f)
      shift
      if test $# -gt 0; then
        get_opened_files $1
      else
        echo "no process specified"
        exit 1
      fi
      shift
      ;;
    *) usage ;;
  esac
done