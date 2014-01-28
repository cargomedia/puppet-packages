define ruby::gem ($ensure = present) {

  class { 'ruby::gems':
    before => Package[ $name ],
  }

  package { $name:
    ensure => $ensure,
    provider => gem,
  }
}
