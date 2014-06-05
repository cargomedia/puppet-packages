#!/bin/sh
<% require 'shellwords' %>

### BEGIN INIT INFO
# Provides:				revealcloud
# Required-Start:		$syslog
# Required-Stop:		$syslog
# Default-Start:		2 3 4 5
# Default-Stop:			0 1 6
# Short-Description:	CopperEgg RevealCloud collector
# Description:			CopperEgg RevealCloud collector
### END INIT INFO

NAME=revealcloud
DESC=revealcloud
DAEMON=<%= @dir %>/revealcloud
PIDDIR=<%= @dir %>/run
PIDFILE=$PIDDIR/revealcloud.pid
DAEMON_ARGS="-d -x -a <%= @api_host.shellescape %> -k <%= @api_key.shellescape %> -P $PIDDIR -l <%= @label.shellescape %> <%= @tag_list.map { |t| "-t #{t.shellescape}" }.join(' ') %>"

test -x ${DAEMON} || exit 0
set -e
. /lib/lsb/init-functions


case "${1}" in
	start)
		log_daemon_msg "Starting ${DESC}" "${NAME}"
		if (start-stop-daemon --start --startas $DAEMON --pidfile $PIDFILE -- $DAEMON_ARGS); then
			log_end_msg 0
		else
			log_end_msg 1
		fi
	;;
	stop)
		log_daemon_msg "Stopping ${DESC}" "${NAME}"
		if (start-stop-daemon --stop --oknodo --retry 20 --pidfile $PIDFILE); then
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
