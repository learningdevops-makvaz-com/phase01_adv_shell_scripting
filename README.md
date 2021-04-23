# Advanced shell scripting

## Task

Update program `proc_info.sh` so it could work in following way:

```bash
vagrant@wordpress:~$ MY_VAR1=foo MY_VAR2=bar sleep 1000 &
[1] 1719
vagrant@wordpress:~$ ./proc_info.sh 1719 -u
vagrant
vagrant@wordpress:~$ ./proc_info.sh 1719 -e
MY_VAR2=bar
MY_VAR1=foo
SHELL=/bin/bash
LANGUAGE=en_US:
PWD=/home/vagrant
LOGNAME=vagrant
XDG_SESSION_TYPE=tty
MOTD_SHOWN=pam
HOME=/home/vagrant
...
vagrant@wordpress:~$ ./proc_info.sh 1719 -c
sleep 1000
vagrant@wordpress:~$ ./proc_info.sh 1719 -f
```

Here in command `MY_VAR1=foo MY_VAR2=bar sleep 1000 &` puts process `sleep 1000` to background. Read [more about it](https://www.howtogeek.com/440848/how-to-run-and-control-background-processes-on-linux/)

This command returns `pid` - proccess id, that you would need to use.

See more in `usage()` function in `proc_info.sh`
