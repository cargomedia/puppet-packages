#!/bin/sh

set -e

HOST="%storage1:IP-PUBLIC%"

echo "Restoring latest backup..."
rm -rf /tmp/restore-shared
rdiff-backup --restore-as-of now /home/backup/shared /tmp/restore-shared

echo "Copying to $HOST..."
scp -pr -C -o CompressionLevel=9 /tmp/restore-shared root@$HOST:/raid/shared
rm -rf /tmp/restore-shared
