define python::pip (
  $ensure = present
){

  require 'apt'
  require 'python'

  package { $name:
    provider => 'apt',
    ensure   => $ensure,
    provider => pip,
  }

}
