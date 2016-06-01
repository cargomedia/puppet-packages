#!/bin/sh
set -e

BlackmagicFirmwareUpdater status | cut -f4 | xargs -I status test "status" = "OK"
