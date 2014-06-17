class gearmand (
  $version = '1.1.2',
  $series = '1.2',
  $username = $gearmand::params::username,
  $confdir = $gearmand::params::confdir,
  $conffile = $gearmand::params::conffile,
  $logdir = $gearmand::params::logdir,
  $piddir = $gearmand::params::piddir
) inherits gearmand::params {

  require 'build'

  include 'gearmand::service'

  if $::lsbdistcodename == 'wheezy' {
    package {['libboost-all-dev', 'libevent-dev', 'libcloog-ppl0', 'libsqlite3-dev']:
      ensure => present,
      before => Helper::Script['install gearman'],
    }
  }

  helper::script {'install gearman':
    content => template('gearmand/install.sh'),
    unless => "test -x /usr/local/sbin/gearmand && /usr/local/sbin/gearmand --version | grep -q '${version}'",
    timeout => 900,
  }

  user {$username:
    ensure => present,
    system => true,
  }
  ~>

  file {[$logdir,$piddir,$confdir]:
    ensure => directory,
    owner => $username,
    group => '0',
    mode => '0755',
    require => User[$username]
  }

}
