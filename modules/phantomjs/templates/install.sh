#!/bin/bash -e

PHANTOMJS='phantomjs-<%= @version %>-linux-x86_64'
PHANTOMJS_URL='https://bitbucket.org/ariya/phantomjs/downloads/${PHANTOMJS}.tar.bz2'

function download_and_unpack_phantomjs {
    curl --fail --retry 5 -sL ${PHANTOMJS_URL} > ${PHANTOMJS}
    tar xjf ${PHANTOMJS}
}

#try three times to successfully execute the function
(tries=3; while ! (download_and_unpack_phantomjs); do ((--tries)) || exit; sleep 5; done)

mv ${PHANTOMJS} phantomjs
rm -rf /usr/local/share/phantomjs
mv phantomjs /usr/local/share/
