#!/bin/bash -e

PHANTOMJS='phantomjs-<%= @version %>-linux-x86_64'
curl -L https://bitbucket.org/ariya/phantomjs/downloads/${PHANTOMJS}.tar.bz2 > ${PHANTOMJS}
tar xjf ${PHANTOMJS}
mv ${PHANTOMJS} phantomjs
rm -rf /usr/local/share/phantomjs
mv phantomjs /usr/local/share/
