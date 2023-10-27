#!/bin/bash

set -x

ls -langv /usr/src/app/gnupg/bin

echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/etc/apache2/sites-enabled/server_name.conf
. /etc/apache2/envvars

exec /usr/sbin/apache2 -DFOREGROUND
