#!/bin/bash -e

usage() { echo "Usage: $0 -h <host> -d <destination>" 1>&2; exit 1; }

while getopts "h:d:" o; do
    case "${o}" in
        h)
            HOST=${OPTARG}
            ;;
        d)
            BACKUP_PATH=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${HOST}" ] || [ -z "${BACKUP_PATH}" ]; then
    usage
fi


PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
LAST_24_HRS=$(($(date +'%s')-86400))
STATUS=0

INCREMENTS=$(rdiff-backup --list-increments --parsable-output root@$HOST::${BACKUP_PATH})
LAST_BACKUP=$(echo "${INCREMENTS}" | tail -n1 | cut -d ' ' -f1)
if [ $((${LAST_BACKUP} - ${LAST_24_HRS})) -lt 0 ]; then
    echo "Backup on ${BACKUP_PATH} is older than 24 hrs. Last one was on: $(date -d@${LAST_BACKUP})"
    STATUS=1
fi

exit $STATUS
