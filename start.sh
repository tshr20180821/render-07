#!/bin/bash

set -x

dpkg -l

tmp1=$(cat ./Dockerfile | head -n 1)
export DOCKER_HUB_PHP_TAG=${tmp1:9}

export DEPLOY_DATETIME=$(date +'%Y%m%d%H%M%S')
export FIXED_THREAD_POOL=1

curl -O https://raw.githubusercontent.com/tshr20180821/render-04/main/auth/exec_log_operation.php
curl -O https://raw.githubusercontent.com/tshr20180821/render-04/main/app/log.php
echo 'function apcu_store($dummy1, $dummy2) {}' >>./log.php
echo 'function apcu_exists($dummy1) {}' >>./log.php
TEST_FILE_NAME_1=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
cp ./test.php /var/www/html/${TEST_FILE_NAME_1}.php
TEST_FILE_NAME_2=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
cp ./exec_log_operation.php /var/www/html/${TEST_FILE_NAME_2}.php
ls -lang

touch /var/www/html/index.html

ls -lang /var/www/html/
/var/www/html/gpg --version

export SQLITE_LOG_DB_FILE="/tmp/sqlitelog.db"

. /etc/apache2/envvars >/dev/null 2>&1

sleep 5s && ps aux && curl -v -m 30 http://127.0.0.1/${TEST_FILE_NAME_1}.php &

for i in {1..20} ; do sleep 10s && ps aux ; done &

exec /usr/sbin/apache2 -DFOREGROUND
