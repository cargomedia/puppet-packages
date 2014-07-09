#!/bin/bash -e

TMPFILE='/tmp/revealcloud-<%= @version %>'

curl -sL '<%= @url %>' > "${TMPFILE}"
set +e
monit-alert none
monit stop revealcloud
monit-alert default
set -e
mv "${TMPFILE}" '<%= @dir %>/revealcloud'
chmod 0755 '<%= @dir %>/revealcloud'
set +e
monit-alert none
monit start revealcloud
monit-alert default
set -e
