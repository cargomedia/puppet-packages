class php5::extension::redis {

  $version = '2.2.3'
  require 'build'
  require 'php5'

  helper::script {'install php5-redis':
    content => template('php5/extension/redis/install.sh'),
    unless => "php --ri redis | grep '^Redis Version => ${version}$'",
    require => Class['php5'],
  }
  ->

  php5::config_extension {'redis':
    content => template('php5/extension/redis/conf.ini'),
  }

}
