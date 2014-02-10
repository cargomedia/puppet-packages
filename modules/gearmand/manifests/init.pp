class gearmand ($version = '1.1.2', $series = '1.2') {

  if $::lsbdistcodename == 'squeeze' {
    $packages = ['libboost-all-dev', 'libevent-dev']
  }

  if $::lsbdistcodename == 'wheezy' {
    $packages = ['libboost-all-dev', 'libevent-dev', 'libcloog-ppl0']
  }

  package {$packages:
    ensure => present,
  }
  ->

  helper::script {'install gearman':
    content => template('gearmand/install.sh'),
    unless => "test -x /usr/local/sbin/gearmand && /usr/local/sbin/gearmand --version | grep -q '${version}'",
  }

}
