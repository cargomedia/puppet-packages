class php5::extension::rdkafka($version = '0.9.1') {

  require 'apt'
  require 'php5'
  require 'build'

  package { 'librdkafka-dev':
    ensure   => present,
    provider => 'apt',
  }
  ->

  helper::script { 'install rdkafka':
    content => template("${module_name}/extension/rdkafka/install.sh"),
    unless  => "php --re rdkafka | grep 'rdkafka version' | grep '${version}'",
  }
  ->

  php5::config_extension { 'rdkafka':
    content => template("${module_name}/extension/rdkafka/conf.ini"),
  }
}
