#!/usr/bin/env bash

set -e

echo '{"message":"debug-1"}' | fluent-cat debug
echo '{"message":"debug-2","level":"notice"}' | fluent-cat debug
echo '{"message":"debug-3","level":"custom"}' | fluent-cat debug

echo 'foo tail-1' > /tmp/my-source
echo 'wrong-message' >> /tmp/my-source
