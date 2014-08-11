#!/bin/sh

### BEGIN INIT INFO
# Provides:          socket-redis
# Required-Start:    $local_fs $syslog
# Required-Stop:     $local_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Starts the socket-redis node script
### END INIT INFO

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
NAME=socket-redis
DESC=socket-redis
DAEMON=/usr/bin/node
DAEMON_USER=socket-redis:socket-redis
PIDFILE=/var/run/socket-redis.pid
LOGDIR="<%= @logDir %>"
DAEMON_ARGS="/usr/bin/socket-redis --log-dir=$LOGDIR --redis-host=<%= @redisHost %> --socket-ports=<%= @socketPorts.join(',') %> --status-port=<%= @statusPort %><%= ' --ssl-key=' + @sslKeyFile if @sslKeyFile %><%= ' --ssl-cert=' + @sslCertFile if @sslCertFile %><%= ' --ssl-pfx=' + @sslPfxFile if @sslPfxFile %><%= ' --ssl-passphrase=' + @sslPassphraseFile if @sslPassphraseFile %>"

test -x $DAEMON || exit 0
set -e
. /lib/lsb/init-functions


case "${1}" in
	start)
		log_daemon_msg "Starting ${DESC}" "${NAME}"
		mkdir -p ${LOGDIR}
		chown ${DAEMON_USER} ${LOGDIR}
		ulimit -n 100000
		if (start-stop-daemon --start --background --make-pidfile --pidfile $PIDFILE --chuid $DAEMON_USER --exec $DAEMON -- $DAEMON_ARGS); then
			log_end_msg 0
		else
			log_end_msg 1
		fi
	;;
	stop)
		log_daemon_msg "Stopping ${DESC}" "${NAME}"
		if (start-stop-daemon --stop --pidfile $PIDFILE --exec $DAEMON); then
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
