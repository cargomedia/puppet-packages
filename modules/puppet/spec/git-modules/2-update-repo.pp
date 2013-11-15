node default {

  require 'git'

  exec {'touch new-file && git add new-file && git commit -m "added new file"':
    cwd => '/tmp/puppet-packages',
    require => Class['git'],
  }
  ->

  puppet::git-modules {'puppet-packages':
    source => '/tmp/puppet-packages',
    version => 'master',
  }
}
