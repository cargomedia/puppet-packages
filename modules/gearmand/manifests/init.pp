class gearmand ($version = '1.1.2', $series = '1.2') {

  if $::lsbdistcodename == 'wheezy' {
    package {['libboost-all-dev', 'libevent-dev', 'libcloog-ppl0']:
      ensure => present,
      before => Helper::Script['install gearman'],
    }
  }

  helper::script {'install gearman':
    content => template('gearmand/install.sh'),
    unless => "test -x /usr/local/sbin/gearmand && /usr/local/sbin/gearmand --version | grep -q '${version}'",
    timeout => 900,
  }

}
