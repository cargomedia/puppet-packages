#!/bin/bash

if [ $# -eq 0 ]; then
    echo 'Usage:'
    echo '   systemctl-status <UnitName>'
    exit 1
fi

( 2>&1 1>/dev/null /bin/systemctl status $1 )
exit $?
