#!/bin/bash

set -x

ls -langv /usr/src/app/gnupg/bin
cp /usr/src/app/gnupg/bin/gpg /var/www/html/

whereis apache2

echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/etc/apache2/sites-enabled/server_name.conf
. /etc/apache2/envvars

exec /usr/sbin/apache2 -DFOREGROUND
