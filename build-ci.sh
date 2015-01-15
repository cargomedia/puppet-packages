#!/bin/bash -e
cd $(dirname $0)

bundle install --path=.bundle

trap 'bundle exec rake test:cleanup' EXIT

bundle exec rake validate
bundle exec rake lint

if [ -z "${ghprbTargetBranch}" ]; then
    # Full project build
    bundle exec rake test
else
    # Pull request build
    bundle exec rake test:changes_from_branch[origin/${ghprbTargetBranch}]
fi
