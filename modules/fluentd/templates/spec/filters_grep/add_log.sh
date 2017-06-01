#!/usr/bin/env bash

set -e

echo '{"message":"bar"}' | fluent-cat debug.test
echo '{"message":"foo","level":"notice"}' | fluent-cat debug.test
echo '{"message":"bar","level":"notice"}' | fluent-cat debug.test
echo '{"message":"foo","level":"warning"}' | fluent-cat debug.test
echo '{"message":"bar","level":"warning"}' | fluent-cat debug.test
