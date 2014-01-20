define ruby::gem ($ensure) {

  if $lsbdistid == 'Debian' and $lsbdistcode == 'squeeze' {
    require 'ruby::gems'
  }

  package {$name:
    ensure => $ensure,
    provider => gem,
  }
}
