define ruby::gem ($ensure = present) {

  require 'ruby::gems'

  package { $name:
    ensure => $ensure,
    provider => gem,
  }
}
