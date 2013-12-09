#!/bin/sh

### BEGIN INIT INFO
# Provides:				copperegg_agents
# Required-Start:		$syslog
# Required-Stop:		$syslog
# Default-Start:		2 3 4 5
# Default-Stop:			0 1 6
# Short-Description:	Copperegg Agent Plugin for CopperEgg RevealCloud collector
# Description:			Copperegg Agent Plugin for CopperEgg RevealCloud collector
### END INIT INFO

NAME=copperegg_agent
DESC=copperegg_agent
DAEMON=/usr/bin/copperegg_agent
PIDFILE=/var/run/copperegg_agent.pid
DAEMON_ARGS="-c /etc/copperegg_agent.yml"
USER=revealcloud

test -x ${DAEMON} || exit 0
set -e
. /lib/lsb/init-functions


case "${1}" in
	start)
		log_daemon_msg "Starting ${DESC}" "${NAME}"
		if (start-stop-daemon --start --startas $DAEMON --pidfile $PIDFILE --chuid $USER -- $DAEMON_ARGS > /var/log/copperegg-agents.log 2>&1 ); then
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
