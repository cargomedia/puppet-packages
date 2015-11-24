class phpmyadmin {

  require 'apt'
  require 'apache2'
  require 'php5::apache2'
  require 'php5::extension::mysql'

  package { 'phpmyadmin':
    provider => 'apt',
    ensure => installed,
  }
  ->

  apache2::vhost { 'phpmyadmin':
    content => template("${module_name}/vhost.conf"),
  }
}
