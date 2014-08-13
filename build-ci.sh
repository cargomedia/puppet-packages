#!/bin/bash -e
cd $(dirname $0)

bundle install --path=.bundle

trap 'bundle exec rake test:cleanup' EXIT

bundle exec rake validate
bundle exec rake lint
bundle exec rake test:git
