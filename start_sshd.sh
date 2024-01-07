#!/bin/bash

set -x

# cat /etc/ssh/sshd_config

curl -Lo /tmp/hpnsshd https://raw.githubusercontent.com/tshr20180821/render-07/main/app/hpnsshd
chmod +x /tmp/hpnsshd

mkdir -p /app/.ssh
chmod 700 /app/.ssh

ssh-keygen -t rsa -N '' -f /app/.ssh/ssh_host_rsa_key

ls -lang /app/.ssh/

cat << EOF >/tmp/hpnsshd_config
AddressFamily inet
ListenAddress 127.0.0.1
Protocol 2
PermitRootLogin no
PasswordAuthentication no
ChallengeResponseAuthentication no
PubkeyAuthentication yes
AuthorizedKeysFile /app/.ssh/ssh_host_rsa_key.pub
X11Forwarding no
PrintMotd no
# LogLevel DEBUG3
LogLevel VERBOSE
AcceptEnv LANG LC_*
PidFile /tmp/hpnsshd.pid
ClientAliveInterval 120
ClientAliveCountMax 3
EOF

useradd --system --shell /usr/sbin/nologin --home=/run/hpnsshd hpnsshd
mkdir /var/empty

/tmp/hpnsshd -4Dp 60022 -h /app/.ssh/ssh_host_rsa_key -f /tmp/hpnsshd_config &

sleep 5s && ps aux && ss -ant &
