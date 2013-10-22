class php5::extension::redis {

  $version = '2.2.3'
  require 'php5'

  helper::script {'install php5-redis':
    content => template('php5/redis/install.sh'),
    unless => "php --ri redis | grep '^Redis Version => ${version}$'"
  }
  ->

  file {'/etc/php5/conf.d/redis.ini':
    ensure => file,
    content => template('php5/redis/conf.ini'),
    owner => '0',
    group => '0',
    mode => '0644',
  }
}
