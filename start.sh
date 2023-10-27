#!/bin/bash

set -x

echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/etc/apache2/sites-enabled/server_name.conf
. /etc/apache2/envvars

exec /usr/sbin/apache2 -DFOREGROUND
