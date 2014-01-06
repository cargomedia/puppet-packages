class php5::extension::suhosin {

  require 'php5'

  package {'php5-suhosin':
    ensure => present,
    require => Class['php5'],
  }

  php5::extension::config{'suhosin':
    settings => {
      'suhosin.executor.include.whitelist' => 'phar'
    }
  }
}
