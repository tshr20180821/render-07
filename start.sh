#!/bin/bash

set -x

dpkg -l

curl -O https://raw.githubusercontent.com/tshr20180821/render-04/main/app/log.php
echo "function apcu_store(dummy1, dummy2) {}" >>./log.php
TEST_FILE_NAME=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
cp ./test.php /var/www/html/${TEST_FILE_NAME}.php
ls -lang

touch /var/www/html/index.html

ls -lang /var/www/html/
/var/www/html/gpg --version

export SQLITE_LOG_DB_FILE="/tmp/sqlitelog.db"

. /etc/apache2/envvars >/dev/null 2>&1

sleep 5s && ps aux && curl https://${RENDER_EXTERNAL_HOSTNAME}/${TEST_FILE_NAME}.php &

exec /usr/sbin/apache2 -DFOREGROUND
