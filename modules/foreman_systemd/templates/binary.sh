#!/usr/bin/env bash
set -e

echoerr () {
  echo "${1}" 1>&2
}

usage() { 
  echoerr "Usage:"
  echoerr "  foreman-systemd install [-u <user>] [-f <formation>] [-l <location>] <app-name> <root-dir>"
  echoerr "  foreman-systemd start <app-name>"
  echoerr "  foreman-systemd stop <app-name>"
  echoerr "  foreman-systemd reload [-u <user>] [-f <formation>] [-l <location>] <app-name> <root-dir>"
  exit 1; 
}

install () {
  USER="${1}"
  FORMATION="${2}"
  APP_NAME="${3}"
  ROOT_DIR="${4}"
  LOCATION="${5}"
  
  foreman export systemd --user "${USER}" --formation "${FORMATION}" --app "${APP_NAME}" --root "${ROOT_DIR}" "${LOCATION}"
  systemctl daemon-reload
}

start () {
  APP_NAME="${1}"
  
  systemctl start "${APP_NAME}.target"
  systemctl enable "${APP_NAME}.target"
}

stop () {
  APP_NAME="${1}"
  systemctl disable "${APP_NAME}.target"
  if (systemctl --quiet is-active "${APP_NAME}.target"); then systemctl stop "${APP_NAME}.target"; fi
}

if [ "$1" == "" ]; then
  echoerr "Missing <command> param"
  echoerr
  usage
fi
COMMAND=$1
shift

case "${COMMAND}" in
  install|start|stop|reload)
    ;;
  *)
    echoerr "Invalid command ${command}"
    echoerr
    usage
    ;;
esac

case "${COMMAND}" in
  install|reload)
    APP_USER="root"
    FORMATION="all=1"
    LOCATION="/etc/systemd/system"
    while getopts "u:f:l:" o; do
        case "${o}" in
            u)
                APP_USER="${OPTARG}"
                ;;
            f)
                FORMATION="${OPTARG}"
                ;;
            l)
                LOCATION="${OPTARG}"
                ;;
            *)
                usage
                ;;
        esac
    done
    shift $((OPTIND-1))
esac


case "${COMMAND}" in
  install|start|stop|reload)
    if [ "$1" == "" ]; then
      echoerr "Missing <app-name> param"
      echoerr
      usage
    fi
    APP_NAME="app-${1}"
    shift
    ;;
esac
  

case "${COMMAND}" in
  install|reload)
    if [ "$1" == "" ]; then
      echoerr "Missing <root-dir> param"
      echoerr
      usage
    fi
    ROOT_DIR=$1
    shift
    ;;
esac


case "${COMMAND}" in
  install)
    install "${APP_USER}" "${FORMATION}" "${APP_NAME}" "${ROOT_DIR}" "${LOCATION}" 
    ;;
  start)
    start "${APP_NAME}"
    ;;
  stop)
    stop "${APP_NAME}"
    ;;
  reload)
    stop ${APP_NAME}
    install "${APP_USER}" "${FORMATION}" "${APP_NAME}" "${ROOT_DIR}" "${LOCATION}"
    start "${APP_NAME}"
    ;;
  *)
    echoerr "Invalid command ${COMMAND}"
    usage
    ;;
esac


