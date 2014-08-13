#!/bin/bash -e
cd $(dirname $0)

bundle install --path=.bundle

bundle exec rake validate
bundle exec rake lint
bundle exec rake test
