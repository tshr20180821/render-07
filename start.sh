#!/bin/bash

set -x

# ls -lang /usr/src/app/gnupg/bin
# cp /usr/src/app/gnupg/bin/gpg /var/www/html/

ls -lang /usr/local/apache2/htdocs/

. /usr/local/apache2/bin/envvars

exec /usr/local/apache2/bin/httpd -DFOREGROUND
