#!/bin/bash

# feel free to use this option in case of wrong parameters set, or help needed
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

while test $# -gt 0; do
  case "$1" in
    -h) usage ;;
    -i)
      shift
      if test $# -gt 0; then
        pid=$1
        who_folder=$(sudo lsof -w -p ${pid} | grep cwd | awk '{ print $9 }')
        who_user=$(sudo lsof -w -p ${pid} | grep cwd | awk '{ print $3 }')
        triggered_by_cmd=$(tr -d '\0' < /proc/$pid/cmdline)
        echo "$pid Process"
        echo "Working directory on $who_folder"
        echo "Ran by user ${who_user}"
        echo "Triggered by command ${triggered_by_cmd}"
      else
        echo "no process specified"
        exit 1
      fi
      shift
      ;;
    -iv2)
      shift
      if test $# -gt 0; then
        pid=$1
        who_folder=$(sudo lsof -w -p ${pid} | grep cwd | awk '{ print $9 }')
        who_user=$(sudo lsof -w -p ${pid} | grep cwd | awk '{ print $3 }')
        triggered_by_cmd=$(tr -d '\0' < /proc/$pid/cmdline)
        echo "$pid Process"
        echo "Working directory on $who_folder"
        echo "Ran by user ${who_user}"
        echo "Triggered by command ${triggered_by_cmd}"
      else
        echo "no process specified"
        exit 1
      fi
      shift
      ;;
    --info*)
      if test $# -gt 0; then
        info $1
      else
        echo "no process specified"
        exit 1
      fi
      shift
      ;;
    *)
      break
      ;;
  esac
done