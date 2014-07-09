#!/bin/bash -e

trap 'monit-alert default' ERR

monit-alert none
monit $@
monit-alert default
