#!/bin/bash -e

trap 'monit-alert default' ERR

monit-alert none
monit $1 $2
monit-alert default
