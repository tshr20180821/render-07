#!/bin/bash

curl -Lo /tmp/hpnsshd https://raw.githubusercontent.com/tshr20180821/render-07/main/app/hpnsshd
chmod +x /tmp/hpnsshd

ssh-keygen -t rsa -N '' -f /tmp/ssh_host_rsa_key

ls -lang /tmp/

