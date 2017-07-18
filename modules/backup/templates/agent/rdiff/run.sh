#!/bin/bash -e

TYPE="${1}" ; shift
ACTION="${1}" ; shift
OUTPUT=""

log_info () {
logger -p 6 "$1"
}

log_error () {
  logger -p 3 "$1"
}

catch_error () {
  EXIT_CODE="${?}"
  if (test ${EXIT_CODE} -gt 0); then
    message="backup ${TYPE}:${ACTION} failed with exit code ${EXIT_CODE}"

    if [ "${OUTPUT}" != "" ]; then
      OUTPUT_FILE="/var/log/backups/${TYPE}.${ACTION}.$(date '+%s').out"
      echo "$OUTPUT" > "${OUTPUT_FILE}"
      message="${message}, see ${OUTPUT_FILE}"
    fi
    log_error "${message}"
  fi
}

trap catch_error ERR

OUTPUT=$(/usr/local/bin/backup-${ACTION}.sh "$@" 2>&1)
log_info "backup ${TYPE}:${ACTION} done successfully"
exit 0
