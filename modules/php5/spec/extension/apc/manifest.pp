node default {

  class {'apt' :
    before => Class['php5'],
  }

  class {'php5::extension::apc':
    shim_size => '64M',
    stat => false,
    enable_cli => false,
  }
}
