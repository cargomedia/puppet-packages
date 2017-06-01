#!/usr/bin/env bash

set -e

echo '{"message":"bar"}' | fluent-cat src1
echo '{"message":"foo","level":"notice"}' | fluent-cat src1
echo '{"message":"bar","level":"notice"}' | fluent-cat src1
echo '{"message":"foo","level":"warning"}' | fluent-cat src1
echo '{"message":"bar","level":"warning"}' | fluent-cat src1

echo '{"message":"toto","unit":"boo"}' | fluent-cat src2
echo '{"message":"toto","unit":"baa"}' | fluent-cat src2
