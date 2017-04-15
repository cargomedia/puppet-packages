#!/bin/bash -e

# Fix cli tools
if !(test -e /usr/share/cacti/lib); then
	ln -s /usr/share/cacti/site/lib /usr/share/cacti/lib
fi
if !(test -e /usr/share/cacti/include); then
	ln -s /usr/share/cacti/site/include /usr/share/cacti/include
fi

sed -i 's#^include_once("../lib/import.php");$#include_once(dirname(__FILE__)."/../lib/import.php");#' /usr/share/cacti/cli/import_template.php

# Change apache template port to 8080
sed -i 's#ss_get_by_ssh.php --host &lt;hostname&gt; --type apache#ss_get_by_ssh.php --host \&lt;hostname\&gt; --port2 8080 --type apache#' /usr/share/cacti/templates/cacti_host_template_x_apache_server*.xml

# Import templates
find /usr/share/cacti/templates -iname '*.xml' -exec php /usr/share/cacti/cli/import_template.php --filename={} \;
