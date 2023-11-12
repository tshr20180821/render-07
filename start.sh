#!/bin/bash

set -x

dpkg -l

ls -lang

ls -lang /usr/local/apache2/htdocs/
/usr/local/apache2/htdocs/gpg --version

find / -name port.conf -print
find / -name httpd.conf -print

# echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/etc/apache2/sites-enabled/server_name.conf

. /usr/local/apache2/bin/envvars

exec /usr/local/apache2/bin/httpd -DFOREGROUND
