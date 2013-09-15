class elasticsearch ($version = '0.90.3') {

  file {'/etc/init.d/elasticsearch':
    ensure => file,
    content => template('elasticsearch/init.sh'),
    owner => '0',
    group => '0',
    mode => '0755',
  }

  file {'/etc/default/elasticsearch':
    ensure => file,
    content => template('elasticsearch/default'),
    owner => '0',
    group => '0',
    mode => '0755',
  }

  helper::script {'install elasticsearch':
    content => template('elasticsearch/install.sh'),
    unless => "test -x /usr/share/elasticsearch/bin/elasticsearch && /usr/share/elasticsearch/bin/elasticsearch -v | grep -q '${version}'"
  }
}
