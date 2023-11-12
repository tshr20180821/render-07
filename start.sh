#!/bin/bash

set -x

dpkg -l

ls -lang

ls -lang /usr/local/apache2/htdocs/
/usr/local/apache2/htdocs/gpg --version

ls -lang /usr/local/apache2/conf/

echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/usr/local/apache2/conf/server_name.conf

. /usr/local/apache2/bin/envvars

exec /usr/local/apache2/bin/httpd -DFOREGROUND
