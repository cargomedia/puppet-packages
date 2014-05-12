define python::pip (
  $ensure = present
){

  require 'python'

  package {$name:
    ensure => $ensure,
    provider => pip,
  }

}
