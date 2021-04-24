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
  #cat /proc/$pid/cmdline ; echo
  IFS=''
  cat /proc/$pid/cmdline |
  while read data
  do
    echo "$data"
  done
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

if [[ $# -eq 1 ]] && [[ $1 == "-h" ]] ; then
	usage
	exit 0
fi
	

if [[ $# < 2 ]] ; then
    echo "You need a PID and a Flag to run this command. Run 'proc_info -h' for help."
    exit 1
fi

while test $# -gt 1; do
  case "$2" in
    -h)
      usage 
      shift
      ;;
    -u)
      get_owner $1
      shift
      ;;
    -c)
      get_command $1
      shift
      ;;
    -e)
      get_env_vars $1
      shift
      ;;
    -f)
      get_opened_files $1
      shift
      ;;
    *)
     echo "Invalid Flag or Option. Run 'proc_info -h' for help" 
     exit 1
     ;;
  esac
done
