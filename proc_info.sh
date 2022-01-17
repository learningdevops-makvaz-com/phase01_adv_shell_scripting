#!/bin/bash

# feel free to use this option in case of wrong parameters set, or help needed
function usage(){
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

case $2 in
        -e)
                echo "Process entered: $2. Below it is shown its environment variables."
                strings /proc/$1/environ
                exit 0
        ;;
        -u)
                echo "Process entered: $2. Below it is shown its owner."
                ps -o user= -p $1
                exit 0
        ;;
        -c)
        ;;
        -f)
                echo "Process entered: $2. Below are shown the files opened by the process."
                sudo ls -l /proc/$1/fd
				exit 0
        ;;
        -h)
                usage
				exit 0
        ;;
        -*)
                echo "Error: no such option $2"
                exit 1
        ;;
esac
