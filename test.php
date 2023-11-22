<?php

include('/usr/src/app/log.php');

error_log('test.php START');

$log = new Log();

error_log('test.php CHECK POINT 010');

$log->trace('php Log Level Test : trace');
$log->debug('php Log Level Test : debug');
$log->info('php Log Level Test : info');
$log->warn('php Log Level Test : warn');
$log->error('php Log Level Test : error');
$log->fatal('php Log Level Test : fatal');

error_log('test.php FINISH');
