#!/usr/bin/env bash

set -e

echo '{"message":"bar","level":"notice","foo":"bar"}' | fluent-cat debug.test
logger -p local0.error foo
