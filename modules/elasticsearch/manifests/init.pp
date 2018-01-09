class elasticsearch (
  $publish_host = undef,
  $heap_size    = '1g',
  $cluster_name = undef
) {

  require 'apt'
  require 'java::jre_headless'
  require 'elasticsearch::package'

  $config_dir = '/etc/elasticsearch'
  $config_file = "${config_dir}/elasticsearch.yml"

  file { $config_dir:
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  file { $config_file:
    ensure  => file,
    content => template("${module_name}/elasticsearch.yml"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['elasticsearch'],
  }

  file { "${config_dir}/jvm.options":
    ensure  => file,
    content => template("${module_name}/jvm.options.erb"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['elasticsearch'],
  }

  file { '/etc/default/elasticsearch':
    ensure  => file,
    content => template("${module_name}/default"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
    notify  => Service['elasticsearch'],
  }

  daemon { 'elasticsearch':
    binary       => '/usr/share/elasticsearch/bin/elasticsearch',
    args         => "-Edefault.path.logs=/var/log/elasticsearch -Edefault.path.data=/var/lib/elasticsearch -Edefault.path.conf=${config_dir}",
    user         => 'elasticsearch',
    env          => {
      'ES_USER'       => 'elasticsearch',
      'ES_GROUP'      => 'elasticsearch',
      'MAX_MAP_COUNT' => '262144',
    },
    require      => File[$config_file],
    limit_nofile => 100000,
  }

  @bipbip::entry { 'elasticsearch':
    plugin  => 'elasticsearch',
    options => {
      'hostname' => 'localhost',
      'port'     => '9200',
    },
  }
}
