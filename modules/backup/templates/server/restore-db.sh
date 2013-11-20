#!/bin/sh

set -e

HOST="%db1:IP-PUBLIC%"

echo "Restoring latest backup..."
rm -rf /tmp/restore-db
rdiff-backup --restore-as-of now /home/backup/db /tmp/restore-db

echo "Copying to $HOST..."
scp -pr -C -o CompressionLevel=9 /tmp/restore-db root@$HOST:/var/lib/mysql
rm -rf /tmp/restore-db
