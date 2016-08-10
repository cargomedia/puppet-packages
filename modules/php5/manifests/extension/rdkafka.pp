class php5::extension::rdkafka($version = '0.9.1') {

  require 'librdkafka'
  require 'php5'

  helper::script { 'install php5::rdkafka':
    content => template("${module_name}/extension/rdkafka/install.sh"),
    unless  => "php --re rdkafka | grep 'rdkafka version' | grep '${version}'",
  }
  ->

  php5::config_extension { 'rdkafka':
    content => template("${module_name}/extension/rdkafka/conf.ini"),
  }
}
