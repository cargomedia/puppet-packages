#!/bin/sh

### BEGIN INIT INFO
# Provides:          pulsar-rest-api
# Required-Start:    $local_fs $syslog
# Required-Stop:     $local_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Starts the pulsar-rest-api node script
### END INIT INFO

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
NAME=pulsar-rest-api
DESC=pulsar-rest-api
DAEMON=/usr/bin/node
DAEMON_USER=pulsar-rest-api:pulsar-rest-api
PIDFILE=/var/run/pulsar-rest-api.pid
LOGDIR="<%= @log_dir %>"
DAEMON_ARGS="/usr/bin/pulsar-rest-api -c /etc/pulsar-rest-api/config.yml"

test -x $DAEMON || exit 0
set -e
. /lib/lsb/init-functions


case "${1}" in
	start)
		log_daemon_msg "Starting ${DESC}" "${NAME}"
		mkdir -p ${LOGDIR}
		chown ${DAEMON_USER} ${LOGDIR}
		ulimit -n 100000
		export LANG=en_US
		DAEMON="/usr/bin/ssh-agent ${DAEMON}"
		if (start-stop-daemon --start --oknodo --make-pidfile --background --pidfile $PIDFILE --chuid $DAEMON_USER --startas $DAEMON -- $DAEMON_ARGS); then
			log_end_msg 0
		else
			log_end_msg 1
		fi
	;;
	stop)
		log_daemon_msg "Stopping ${DESC}" "${NAME}"
		if (start-stop-daemon --stop --oknodo --retry TERM/20/TERM/20 --pidfile $PIDFILE --chuid $DAEMON_USER); then
			log_end_msg 0
		else
			log_end_msg 1
		fi
	;;
	status)
		status_of_proc -p ${PIDFILE} ${DAEMON} ${NAME}
	;;
	restart)
		${0} stop
		${0} start
	;;
	*)
		echo "Usage: ${0} {start|stop|status|restart}" >&2
	;;
esac

exit 0
