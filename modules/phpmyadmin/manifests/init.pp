class phpmyadmin {

  require 'apache2'
  require 'php5::apache2'
  require 'php5::extension::mysql'

  package {'phpmyadmin':
    ensure => installed,
  }
  ->

  apache2::vhost {'phpmyadmin':
    content => template('phpmyadmin/vhost.conf'),
  }
}
