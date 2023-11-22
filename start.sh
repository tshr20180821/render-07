#!/bin/bash

set -x

dpkg -l

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

sleep 5s && ps aux && curl -v -m 60 http://127.0.0.1/${TEST_FILE_NAME_1}.php \
  && java -classpath .:sqlite-jdbc-${SQLITE_JDBC_VERSION}.jar:slf4j-api-2.0.9.jar:slf4j-nop-2.0.9.jar:LogOperation.jar -Duser.timezone=Asia/Tokyo -Dfile.encoding=UTF-8 LogOperationMain &

exec /usr/sbin/apache2 -DFOREGROUND
