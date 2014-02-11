class gearmand ($version = '1.1.2', $series = '1.2') {

  case $::lsbdistcodename {
    'squeeze': {
      require 'gearmand::deps::debian_squeeze'
    }
    'wheezy': {
      require 'gearmand::deps::debian_wheezy'
    }
  }

  helper::script {'install gearman':
    content => template('gearmand/install.sh'),
    unless => "test -x /usr/local/sbin/gearmand && /usr/local/sbin/gearmand --version | grep -q '${version}'",
  }

}
