#!/bin/bash -e

TMPFILE='/tmp/revealcloud-<%= @version %>'
PIDFILE='<%= @dir %>/run/revealcloud.pid'

daemon () {
  INITSCRIPT='/etc/init.d/revealcloud'
  if !(test -x ${INITSCRIPT}); then
    return 0
  fi
  if [ "${1}" == 'stop' ] && !(ps -p $(cat ${PIDFILE}) > /dev/null); then
    return 0
  fi

  if (which monit >/dev/null && test -f /etc/monit/conf.d/revealcloud); then
    set +e
    monit-alert none
    monit ${1} revealcloud
    monit-alert default
    set -e
  else
    ${INITSCRIPT} ${1};
  fi
  if [ "${1}" == 'stop' ]; then
    timeout --signal=9 5 bash -c 'while (ps -p $(cat ${PIDFILE}) >/dev/null);do true; done'
  fi
}

curl -sL '<%= @url %>' > "${TMPFILE}"
daemon stop
mv "${TMPFILE}" '<%= @dir %>/revealcloud'
chmod 0755 '<%= @dir %>/revealcloud'
daemon start
