class gearmand ($server_version = '1.1.2', $server_series = '1.2') {

  package {['libboost-all-dev', 'libevent-dev']:
    ensure => present,
  }
  ->

  helper::script {'install gearman':
    content => template('gearmand/install.sh'),
    unless => "test -x /usr/local/sbin/gearmand  && /usr/local/sbin/gearmand --version | grep -q '${server_version}')",
  }

}
