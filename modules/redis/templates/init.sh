#! /bin/sh

### BEGIN INIT INFO
# Provides:				redis-server
# Required-Start:		$syslog
# Required-Stop:		$syslog
# Should-Start:			$local_fs
# Should-Stop:			$local_fs
# Default-Start:		2 3 4 5
# Default-Stop:			0 1 6
# Short-Description:	redis-server - Persistent key-value db
# Description:			redis-server - Persistent key-value db
### END INIT INFO

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=/usr/local/bin/redis-server
REDIS_CLI=/usr/local/bin/redis-cli
CONFIG_FILE=/etc/redis.conf
DAEMON_ARGS="$CONFIG_FILE"
NAME=redis-server
DESC=redis-server
PIDFILE=/var/run/redis.pid
LOGFILE=/var/log/redis.log
DATADIR=/var/lib/redis/

test -x ${DAEMON} || exit 0
set -e
. /lib/lsb/init-functions


case "${1}" in
	start)
		log_daemon_msg "Starting ${DESC}" "${NAME}"
		touch $PIDFILE $LOGFILE
		mkdir -p $DATADIR
		chown redis:redis $PIDFILE $LOGFILE $DATADIR
		if (start-stop-daemon --start --umask 007 --pidfile $PIDFILE --chuid redis:redis --exec $DAEMON -- $DAEMON_ARGS); then
			log_end_msg 0
		else
			log_end_msg 1
		fi
	;;
	stop)
		log_daemon_msg "Stopping ${DESC}" "${NAME}"
		if [ ! -e "$PIDFILE" ];	then
			echo "failed"
		else
			LISTENING_PORT=`grep -E "^port +([0-9]+)" "$CONFIG_FILE" | grep -Eo "[0-9]+"`
			$REDIS_CLI -p $LISTENING_PORT SHUTDOWN
		fi
	;;
	restart)
		${0} stop
		${0} start
	;;
	*)
		echo "Usage: $0 {start|stop|restart}" >&2
	;;
esac

exit 0
