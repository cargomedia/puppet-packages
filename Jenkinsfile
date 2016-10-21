node {
  checkout scm
  try {
    sh '''
      bundle exec rake syntax
      bundle exec rake lint

      vagrant box update
      if [ -z "${ghprbTargetBranch}" ]; then
          # Full project build
          bundle exec rake spec
      else
          # Pull request build
          git fetch origin
          bundle exec rake spec:changes_from_branch[origin/${ghprbTargetBranch}]
      fi
    '''
  } finally {
    sh 'bundle exec rake spec:cleanup'
  }
}
