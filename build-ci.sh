#!/bin/bash -e
cd $(dirname $0)

bundle install

trap 'bundle exec rake spec:cleanup' EXIT

bundle exec rake syntax
bundle exec rake lint

vagrant box update
if [ -z "${ghprbTargetBranch}" ]; then
    # Full project build
    bundle exec rake spec
else
    # Pull request build
    git fetch origin
    no_retries=true bundle exec rake spec:changes_from_branch[origin/${ghprbTargetBranch}]
fi
