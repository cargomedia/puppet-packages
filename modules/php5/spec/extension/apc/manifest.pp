node default {

  class {'php5::extension::apc':
    shim_size => '64M',
    stat => false,
    enable_cli => false,
    cache_by_default => false,
  }
}
