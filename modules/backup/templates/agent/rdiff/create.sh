#!/bin/bash -e

trap 'if (test ${?} -gt 0); then echo "Non-zero exit in ${0} - line ${LINENO}: ${BASH_COMMAND}"; fi' ERR EXIT

usage() { echo "Usage: $0 -h <host> -s <source> -d <destination> -o <rdiff-options> -t <mysql|lvm>" 1>&2; exit 1; }

while getopts "h:s:d:o:t:" o; do
    case "${o}" in
        h)
            HOST=${OPTARG}
            ;;
        s)
            SOURCE_PATH=${OPTARG}
            ;;
        d)
            DEST_PATH=${OPTARG}
            ;;
        o)
            RDIFF_OPTIONS=${OPTARG}
            ;;
        t)
            TYPE=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${HOST}" ] || [ -z "${SOURCE_PATH}" ] || [ -z "${DEST_PATH}" ] || [ -z "${RDIFF_OPTIONS}" ]; then
    usage
fi


PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

case "${TYPE}" in
"mysql")
    which monit-alert >/dev/null && monit-alert none
    which monit >/dev/null && monit unmonitor mysql
    /etc/init.d/mysql stop >/dev/null

    rm -rf /tmp/backup-db
    cp -a ${SOURCE_PATH} /tmp/backup-db

    /etc/init.d/mysql start >/dev/null
    which monit >/dev/null && monit monitor mysql
    which monit-alert >/dev/null && monit-alert default

    ssh root@${HOST} "mkdir -p ${DEST_PATH}"
    rdiff-backup ${RDIFF_OPTIONS} /tmp/backup-db root@${HOST}::${DEST_PATH} >/dev/null

    rm -rf /tmp/backup-db

    ;;
"mysql-dump")
    rm -rf /tmp/backup-db-dump
    mkdir -p /tmp/backup-db-dump

    mysqldump ${SOURCE_PATH} > /tmp/backup-db-dump/dump.sql
    ssh root@${HOST} "mkdir -p ${DEST_PATH}"
    rdiff-backup ${RDIFF_OPTIONS} /tmp/backup-db-dump root@${HOST}::${DEST_PATH} >/dev/null

    rm -rf /tmp/backup-db-dump

    ;;
"lvm")
    KEEP=2
    BACKUP_MNT=/raid-backup
    VG_NAME=$(expr "${SOURCE_PATH}" : "^/.*/\(.*\)/.*$")
    LV_NAME=$(expr "${SOURCE_PATH}" : "^/.*/\(.*\)$")
    SNAPSHOTS=$(lvs | perl -ne 'print "$1\n" if /'${LV_NAME}'-snap(\d+)/' | sort -r)

    for i in $SNAPSHOTS; do
    	MOUNTPOINT="/dev/mapper/${VG_NAME}-${LV_NAME}--snap${i}"
    	if (grep -q "^${MOUNTPOINT} " /proc/mounts); then
    		umount ${SOURCE_PATH}-snap${i}
    	fi
    done
    for i in $SNAPSHOTS; do
    	if [ "${i}" -ge "${KEEP}" ]; then
    		lvremove -f ${SOURCE_PATH}-snap${i} >/dev/null
    	else
    		lvrename ${SOURCE_PATH}-snap${i} ${SOURCE_PATH}-snap$((${i}+1)) >/dev/null
    	fi
    done
    lvcreate -s ${SOURCE_PATH} -l $((10/$KEEP))%VG --name ${SOURCE_PATH}-snap1 >/dev/null

    mkdir -p ${BACKUP_MNT}
    mount -o nouuid,inode64,nobarrier,ro ${SOURCE_PATH}-snap1 ${BACKUP_MNT}
    ssh root@${HOST} "mkdir -p ${DEST_PATH}"
    rdiff-backup ${RDIFF_OPTIONS} ${BACKUP_MNT} root@${HOST}::${DEST_PATH} >/dev/null
    umount ${BACKUP_MNT}

    ;;
"dir")
    ssh root@${HOST} "mkdir -p ${DEST_PATH}"
    rdiff-backup ${RDIFF_OPTIONS} ${SOURCE_PATH} root@${HOST}::${DEST_PATH} >/dev/null

    ;;
*)
    usage
    ;;
esac


rdiff-backup --remove-older-than 4W --force root@${HOST}::${DEST_PATH} >/dev/null
