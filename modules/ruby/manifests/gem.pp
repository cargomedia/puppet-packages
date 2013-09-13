define ruby::gem ($ensure) {

  require 'ruby::gems'

  package {$name:
    ensure => $ensure,
    provider => gem,
  }
}
