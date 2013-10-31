node default {

  class {'apt' :
    before => Class['php5'],
  }

  class {'php5::extension::apc':
    shimSize => '64M',
    stat => false,
  }
}
