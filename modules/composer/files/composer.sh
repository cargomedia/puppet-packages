#!/usr/bin/env bash
/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off /usr/local/lib/composer.phar $*
