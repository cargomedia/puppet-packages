class mongodb::install ($version = '2.6.0') {

  include 'mongodb'

  package {'mongodb-org':
    ensure => $version,
  }
  ->

  service {'mongod':
    ensure     => stopped,
    enable     => false,
    hasstatus  => true,
    hasrestart => true,
  }
  ->

  file {'/etc/init.d/mongod':
    ensure  => file,
    content => template('mongodb/init-replacement'),
    mode    => '0755',
  }

}
