<?php

include('/usr/src/app/log.php');

error_log('test.php START');

$log = new Log();

$log->trace('php Log Level Test : trace');
$log->debug('php Log Level Test : debug');
$log->info('php Log Level Test : info');
$log->warn('php Log Level Test : warn');
$log->error('php Log Level Test : error');
$log->fatal('php Log Level Test : fatal');

exec('cd /usr/src/app && java -Xmx256m -Xms64m -classpath .:sqlite-jdbc-' . $_ENV['SQLITE_JDBC_VERSION']
     . '.jar:slf4j-api-2.0.17.jar:slf4j-nop-2.0.17.jar:LogOperation.jar -Duser.timezone=Asia/Tokyo -Dfile.encoding=UTF-8 LogOperationMain &');

error_log('test.php FINISH');
