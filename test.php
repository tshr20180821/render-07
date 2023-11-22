<?php

include('/usr/src/app/log.php');

error_log('test.php START');

/*
$log = new Log();

error_log('test.php CHECK POINT 010');

$log->trace('php Log Level Test : trace');
$log->debug('php Log Level Test : debug');
$log->info('php Log Level Test : info');
$log->warn('php Log Level Test : warn');
$log->error('php Log Level Test : error');
$log->fatal('php Log Level Test : fatal');
*/


            $pdo = new PDO('sqlite:' . $_ENV['SQLITE_LOG_DB_FILE'], NULL, NULL, array(PDO::ATTR_PERSISTENT => TRUE));

error_log('test.php CHECK POINT 010');

            $sql_create = <<< __HEREDOC__
CREATE TABLE t_log (
    seq INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    regist_datetime TIMESTAMP DEFAULT (DATETIME('now','localtime')),
    process_datetime TEXT NOT NULL,
    pid TEXT NOT NULL,
    level TEXT NOT NULL,
    file TEXT NOT NULL,
    line TEXT NOT NULL,
    function TEXT NOT NULL,
    message TEXT,
    tags TEXT,
    status INTEGER NOT NULL
)
__HEREDOC__;

error_log('test.php CHECK POINT 020');
            $rc = $pdo->exec($sql_create);

error_log('test.php CHECK POINT 030');
            exec('cd /usr/src/app && java -classpath .:sqlite-jdbc-' . $_ENV['SQLITE_JDBC_VERSION']
                 . '.jar:slf4j-api-2.0.9.jar:slf4j-nop-2.0.9.jar:LogOperation.jar -Duser.timezone=Asia/Tokyo -Dfile.encoding=UTF-8 LogOperationMain &');

error_log('test.php FINISH');
