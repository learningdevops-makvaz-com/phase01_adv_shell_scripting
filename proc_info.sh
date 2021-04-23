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
