#!/bin/bash +e

QUERY_RESULT=${QUERY_RESULT_SPEC:-$(2>&1 mysql --execute="show global status like 'Slave_running';" --user=${1} --password=${2})}

case "${QUERY_RESULT}" in
  *Access?denied*)
    MSG='mysql denied access'
    ;;
  *Slave_running*ON)
    MSG='running'
    ;;
  *Slave_running*OFF)
    MSG='not running'
    ;;
  *)
    MSG='unknown'
    ;;
esac

if ! (systemctl is-active mysql >/dev/null); then
  MSG='server stopped'
fi
# Boolean ture (Replication failure) only if query result returns that replication is OFF
# All other states (server down, access denied, etc) will return "Replication failure: false"
echo "{\"mysql slave replication failure\": \"$([[ "$MSG" == "not running" ]] && echo true || echo false)\"}"
