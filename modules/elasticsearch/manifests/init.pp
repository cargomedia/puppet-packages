class elasticsearch ($publish_host, $heap_size = '256m', $cluster_name = undef) {

  require 'java'

  $version = '0.90.5'

  file {'/etc/default/elasticsearch':
    ensure => file,
    content => template('elasticsearch/default'),
    owner => '0',
    group => '0',
    mode => '0755',
    before => Helper::Script['install elasticsearch'],
  }

  file {'/etc/elasticsearch':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0755',
  }

  file {'/etc/elasticsearch/elasticsearch.yml':
    ensure => file,
    content =>template('elasticsearch/elasticsearch.yml'),
    owner => '0',
    group => '0',
    mode => '0755',
    before => Helper::Script['install elasticsearch'],
  }

  helper::script {'install elasticsearch':
    content => template('elasticsearch/install.sh'),
    unless => "test -x /usr/share/elasticsearch/bin/elasticsearch && /usr/share/elasticsearch/bin/elasticsearch -v | grep -q '${version}'"
  }

  @monit::entry {'elasticsearch':
    content => template('elasticsearch/monit'),
    require => Helper::Script['install elasticsearch'],
  }
}
