class php5::config_extension_change {

  exec { 'echo Triggering refresh because php extensions configuration changed':
    provider    => shell,
    refreshonly => true,
  }
}
