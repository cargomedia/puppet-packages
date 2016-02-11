node default {

  php5::config_extension { 'imagick-config-ovverride':
    extension => 'imagick',
    content => "extension=imagick.so\n#progress_monitor=true"
  }
  ->

  class { 'php5::extension::imagick': }
}
