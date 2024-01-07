#!/bin/bash

cat /etc/ssh/sshd_config

curl -Lo /tmp/hpnsshd https://raw.githubusercontent.com/tshr20180821/render-07/main/app/hpnsshd
chmod +x /tmp/hpnsshd

ls -lang /tmp/

mkdir /app/.ssh
chmod 700 /app/.ssh

ssh-keygen -t rsa -N '' -f /app/.ssh/ssh_host_rsa_key

/tmp/hpnsshd -4 -D -p 60022 -h /app/.ssh/ssh_host_rsa_key &

sleep 5s && ps aux &
