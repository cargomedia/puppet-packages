#!/usr/bin/env bash
set -e

echoerr () {
  echo "${1}" 1>&2
}

usage() { 
  echoerr "Usage:"
  echoerr "  foreman-systemd install [-u <user>] <app-name> <procfile-path>"
  echoerr "  foreman-systemd start <app-name>"
  echoerr "  foreman-systemd stop <app-name>"
  echoerr "  foreman-systemd reload [-u <user>] <app-name> <procfile-path>"
  exit 1; 
}

install () {
  uninstall "${2}"
  foreman export systemd --user "${1}" --app "${2}" --procfile "${3}"
}

uninstall () {
  rm -rf "/etc/systemd/systemd/${1}"
}

start () {
  systemctl start "${1}.target"
  systemctl enable "${1}.target"
}

stop () {
  systemctl disable "${1}.target"
  systemctl stop "${1}.target"
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
    APP_USER=root
    while getopts "u:" o; do
        case "${o}" in
            u)
                APP_USER=${OPTARG}
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
      echoerr "Missing <profile-path> param"
      echoerr
      usage
    fi
    ROOT_DIR=$(dirname $1)
    shift
    ;;
esac


case "${COMMAND}" in
  install)
    install $APP_USER $APP_NAME $ROOT_DIR
    ;;
  start)
    start $APP_NAME
    ;;
  stop)
    stop $APP_NAME
    ;;
  reload)
    stop $APP_NAME
    install $APP_USER $APP_NAME $ROOT_DIR
    start $APP_NAME
    ;;
  *)
    echoerr "Invalid command ${COMMAND}"
    usage
    ;;
esac


