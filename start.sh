#!/bin/bash

set -x

# ls -lang /usr/src/app/gnupg/bin
# cp /usr/src/app/gnupg/bin/gpg /var/www/html/

whereis apache2
find / -name envvars -print

# echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >/etc/apache2/sites-enabled/server_name.conf
# . /etc/apache2/envvars

# exec /usr/sbin/apache2 -DFOREGROUND
exec apache2 -DFOREGROUND
