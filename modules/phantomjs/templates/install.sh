#!/bin/bash -e

PHANTOMJS='phantomjs-<%= @version %>-linux-x86_64'
curl -L https://bitbucket.org/ariya/phantomjs/downloads/${PHANTOMJS}.tar.bz2 > ${PHANTOMJS}
unp ${PHANTOMJS}
mv ${PHANTOMJS} phantomjs
mv phantomjs /usr/local/share/
