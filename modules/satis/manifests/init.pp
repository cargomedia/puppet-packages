class satis($hostname) {

  require 'composer'
  require 'git'

  $version = '3d27252f3e3d5992b382a54f4911510048320b2a'

  file {'/etc/satis':
    ensure => 'directory',
    owner => '0',
    group => '0',
    mode => '0755',
  }

  user {'satis':
    ensure => present,
    system => true,
    managehome => true,
    home => '/var/lib/satis',
  }

  exec {'install satis':
    command => "composer --no-interaction create-project composer/satis --stability=dev --keep-vcs /var/lib/satis/satis",
    creates => '/var/lib/satis/satis',
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user => 'satis',
    environment => ['HOME=/var/lib/satis'],
  }
  ->

  exec {'upgrade satis':
    command => "git fetch && git checkout ${version} && composer --no-interaction install",
    cwd => '/var/lib/satis/satis',
    unless => "test $(git rev-parse HEAD) = ${version}",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user => 'satis',
    environment => ['HOME=/var/lib/satis'],
  }
  ->

  file {'/var/lib/satis/public':
    ensure => 'directory',
    owner => 'satis',
    group => 'satis',
    mode => '0755',
  }
  ->

  apache2::vhost{$hostname:
    content => template('satis/vhost'),
  }
}
