class satis($hostname) {

  require 'composer'
  require 'git'

  $version = 'b20fd944ec40ad65c1e54bb0860fe844f4efd56e' # 1.0.0-alpha1

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
    command => "git fetch && git checkout ${version} && composer --no-interaction --no-dev install",
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
