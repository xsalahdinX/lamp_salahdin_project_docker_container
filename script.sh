#!/bin/bash

php-fpm -D

/usr/sbin/apachectl -D FOREGROUND
  
# Wait for any process to exit
wait -n
  
# Exit with status of process that exited first
exit $?
