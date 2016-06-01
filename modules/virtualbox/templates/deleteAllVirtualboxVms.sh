#!/bin/bash
set -e

if [ $# -lt 1 ]; then
  echo "USAGE: $0 <user>"
  exit 1
fi

user=$1
vboxmanage="sudo -u ${user} VBoxManage"

listVms() {
  echo 'VMs:'
  echo '===='
  ${vboxmanage} list vms
  echo '===='
}

listVms

echo 'Shutting down VMs…'
${vboxmanage} list runningvms | awk '{print $2;}' | xargs -I vmid ${vboxmanage} controlvm vmid poweroff

echo 'Unregistering VMs…'
${vboxmanage} list vms | awk '{print $2;}' | xargs -I vmid ${vboxmanage} unregistervm vmid --delete

listVms
