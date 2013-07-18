#!/bin/bash
set -e
cd /tmp

curl -sL http://pecl.php.net/get/APC-<%= @version %>.tgz | tar -xzf -
cd APC-<%= @version %>/
phpize
./configure --enable-apc-mmap --enable-apc-pthreadmutex --disable-apc-debug --disable-apc-filehits --disable-apc-spinlocks
make
make install
