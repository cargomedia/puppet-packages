node default {
  
  class { 'php5::extension::rdkafka':
    version => '0.9.1'
  }
}
