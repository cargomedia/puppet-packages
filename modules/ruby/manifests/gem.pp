define ruby::gem ($ensure = present) {

  require 'apt'
  require 'ruby'

  package { $name:
    provider => 'apt',
    ensure   => $ensure,
    provider => gem,
  }
}
