class kafka($version = '0.9.1') {

  require 'apt'
  require 'php5'

  package { 'librdkafka-dev':
    ensure   => present,
    provider => 'apt',
  }
  ->

  helper::script { 'install php5::rdkafka':
    content => template("${module_name}/install.sh"),
    unless  => "php --re rdkafka | grep 'rdkafka version' | grep '${version}'",
  }
  ->

  php5::config_extension { 'rdkafka':
    content => template("${module_name}/conf.ini"),
  }
}
