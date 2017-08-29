#!/usr/bin/env bash


unit_failed() {
  if (/bin/systemctl is-failed $1 -q); then
    return 0
  else
    return 1
  fi
}

unit_stopped() {
  if !(/bin/systemctl is-active $1 -q); then
    if (unit_failed $1); then
      return 1
    else
      return 0
    fi
  else
    return 1
  fi
}

while true; do
  units=$(/bin/systemctl --plain list-dependencies critical-units.target | cut -d " " -f 2)
  for s in $units; do
    if (unit_failed $s); then 1>&2 echo "Critical unit failed: $s"; fi
    if (unit_stopped $s); then 1>&2 echo "Critical unit stopped: $s"; fi
  done
  sleep 20
done
