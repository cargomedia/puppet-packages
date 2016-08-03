class elasticsearch (
  $publish_host = undef,
  $heap_size = undef,
  $cluster_name = undef
) {

  require 'apt'
  require 'java::jre_headless'

  $config_dir = '/etc/elasticsearch'
  $config_file = "${config_dir}/elasticsearch.yml"

  $version = '1.3.1'

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
    before  => Helper::Script['install elasticsearch'],
    notify  => Service['elasticsearch'],
  }

  helper::script { 'install elasticsearch':
    content => template("${module_name}/install.sh"),
    unless  => "/usr/share/elasticsearch/bin/elasticsearch -v | grep -q '\s${version},'",
    require => Class['apt::update'],
  }
  ->

  daemon { 'elasticsearch':
    binary           => '/usr/share/elasticsearch/bin/elasticsearch',
    env              => {
      'ES_HEAP_SIZE' => $heap_size,
      'ES_USER' => 'elasticsearch',
      'ES_GROUP' => 'elasticsearch',
      'MAX_MAP_COUNT' => '262144',
      'LOG_DIR' => '/var/log/elasticsearch',
      'DATA_DIR' => '/var/lib/elasticsearch',
      'WORK_DIR' => '/tmp/elasticsearch',
      'CONF_DIR' => $config_dir,
      'CONF_FILE' => $config_file,
      'RESTART_ON_UPGRADE' => 'true'
    }
  }

  @bipbip::entry { 'elasticsearch':
    plugin  => 'elasticsearch',
    options => {
      'hostname' => 'localhost',
      'port' => '9200',
    },
  }
}
