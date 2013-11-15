node default {

  require 'git'

  exec {'git clone https://github.com/cargomedia/puppet-packages.git /tmp/puppet-packages':
    require => Class['git'],
  }
  ->

  puppet::git-modules {'puppet-packages':
    source => '/tmp/puppet-packages',
    version => 'master',
  }
}
