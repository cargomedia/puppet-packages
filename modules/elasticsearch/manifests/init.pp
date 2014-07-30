class elasticsearch (
  $publish_host = undef,
  $heap_size = undef,
  $cluster_name = undef
) {

  require 'java'

  $version = '1.1.1'

  file {'/etc/default/elasticsearch':
    ensure => file,
    content => template('elasticsearch/default'),
    owner => '0',
    group => '0',
    mode => '0755',
    before => Helper::Script['install elasticsearch'],
    notify => Service['elasticsearch'],
  }

  file {'/etc/elasticsearch':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0755',
  }

  file {'/etc/elasticsearch/elasticsearch.yml':
    ensure => file,
    content => template('elasticsearch/elasticsearch.yml'),
    owner => '0',
    group => '0',
    mode => '0644',
    before => Helper::Script['install elasticsearch'],
    notify => Service['elasticsearch'],
  }

  helper::script {'install elasticsearch':
    content => template('elasticsearch/install.sh'),
    unless => "/usr/share/elasticsearch/bin/elasticsearch -v | grep -q '\s${version},'"
  }
  ->

  service {'elasticsearch':
    hasrestart => true,
  }

  @monit::entry {'elasticsearch':
    content => template('elasticsearch/monit'),
    require => Service['elasticsearch'],
  }
}
