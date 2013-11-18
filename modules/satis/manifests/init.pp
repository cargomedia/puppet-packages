class satis($hostname) {

  require 'composer'
  require 'git'
  require 'github::knownhost'

  $version = 'dev-master'

  user {'satis':
    ensure => present,
    system => true,
    managehome => true,
    home => '/var/lib/satis',
  }

  exec {"composer --no-interaction create-project --keep-vcs composer/satis /var/lib/satis/satis ${version}":
    creates => '/var/lib/satis/satis',
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user => 'satis',
    environment => ['HOME=/var/lib/satis'],
  }
  ->

  exec {'git pull && composer --no-interaction install':
    cwd => '/var/lib/satis/satis',
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user => 'satis',
    environment => ['HOME=/var/lib/satis'],
  }
}
