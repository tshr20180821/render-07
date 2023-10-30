#!/bin/bash

set -x

dpkg -l
cat /etc/apt-fast.conf

ls -lang /usr/local/apache2/htdocs/
/usr/local/apache2/htdocs/gpg --version

. /usr/local/apache2/bin/envvars

exec /usr/local/apache2/bin/httpd -DFOREGROUND
