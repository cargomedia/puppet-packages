class base::tools {

  require 'vim'

  package {'unp': ensure => installed }
  package {'screen': ensure => installed }
  package {'parallel': ensure => installed }
  package {'sysstat': ensure => installed }
  package {'zip': ensure => installed }
  package {'htop': ensure => installed }
  package {'iftop': ensure => installed }
  package {'iotop': ensure => installed }
  package {'tree': ensure => installed }
}
