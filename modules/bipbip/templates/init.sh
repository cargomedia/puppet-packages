#!/bin/sh

### BEGIN INIT INFO
# Provides:				bipbip
# Required-Start:		$syslog
# Required-Stop:		$syslog
# Default-Start:		2 3 4 5
# Default-Stop:			0 1 6
# Short-Description:	Bipbip
# Description:			Gather services data and store in CopperEgg
### END INIT INFO

NAME=bipbip
DESC=bipbip
DAEMON=/usr/local/bin/bipbip
PIDFILE=/var/run/bipbip.pid
DAEMON_ARGS="-c /etc/bipbip/config.yml"
USER=bipbip

test -x ${DAEMON} || exit 0
set -e
. /lib/lsb/init-functions


case "${1}" in
	start)
		log_daemon_msg "Starting ${DESC}" "${NAME}"
		if (start-stop-daemon --start --startas $DAEMON --pidfile $PIDFILE --make-pidfile --background --chuid $USER -- $DAEMON_ARGS); then
			log_end_msg 0
		else
			log_end_msg 1
		fi
	;;
	stop)
		log_daemon_msg "Stopping ${DESC}" "${NAME}"
		if (start-stop-daemon --stop --oknodo --retry 20 --pidfile $PIDFILE --user $USER); then
			rm -f $PIDFILE
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
