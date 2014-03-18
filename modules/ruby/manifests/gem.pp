define ruby::gem ($ensure = present) {

  require 'ruby'

  package { $name:
    ensure => $ensure,
    provider => gem,
  }
}
