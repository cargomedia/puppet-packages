class librdkafka($version = '0.9.1') {

  require 'build'

  helper::script { 'install librdkafka':
    content => template("${module_name}/install.sh"),
    unless  => "ls /usr/local/lib/librdkafka.so.1",
  }
}
