#!/bin/bash

if [ "$(id -u)" != "0" ]; then
 echo "requires superuser privileges."
 exit 1
fi

pid_file="/var/run/vpn-start.pid"
log_file="/var/log/vpn-start.log"

if [ -e "$pid_file" ]; then 
 pid=$(cat "$pid_file")
 if ps -p "$pid" > /dev/null; then
  echo "The process is already running with PID $pid."
  exit 1
 else
  rm "$pid_file"
 fi
fi

user_home=$(getent passwd "$SUDO_USER" | cut -d: -f6)

cd "$user_home/.vpn"

code=$(2fa vpn)

expect -c '
 set timeout 4

 spawn openvpn config.ovpn

 set pid [exp_pid]
 exec echo $pid > '"$pid_file"'

 expect "CHALLENGE: Verification code:"
 send '"$code\n"'
 log_file '"$log_file"'
 expect eof
'

echo "VPN started with $(cat $pid_file)"
