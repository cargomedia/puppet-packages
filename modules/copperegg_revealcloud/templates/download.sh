#!/bin/bash -e

TMPFILE='/tmp/revealcloud-<%= @version %>'
curl -sL '<%= @url %>' > "${TMPFILE}"
chmod 0755 "${TMPFILE}"
mv "${TMPFILE}" '<%= @dir %>/revealcloud'
