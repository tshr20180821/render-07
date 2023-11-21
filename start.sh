#!/bin/bash

set -x

dpkg -l

tmp1=$(cat ./Dockerfile | head -n 1)
echo ${tmp1:8}

curl -O https://raw.githubusercontent.com/tshr20180821/render-04/main/app/log.php
TEST_FILE_NAME=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1)
cp ./test.php /usr/local/apache2/htdocs/${TEST_FILE_NAME}.php
ls -lang

touch /usr/local/apache2/htdocs/index.html

ls -lang /usr/local/apache2/htdocs/
/usr/local/apache2/htdocs/gpg --version

echo ServerName ${RENDER_EXTERNAL_HOSTNAME} >>/usr/local/apache2/conf/httpd.conf

. /usr/local/apache2/bin/envvars

sleep 5s && curl https://${RENDER_EXTERNAL_HOSTNAME}/${TEST_FILE_NAME}.php

exec /usr/local/apache2/bin/httpd -DFOREGROUND
