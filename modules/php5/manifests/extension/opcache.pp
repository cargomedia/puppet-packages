class php5::extension::opcache (
  $version = '7.0.3',
  $version_output = '7.0.3FE',
  $enable = true,
  $enable_cli = false,
  $memory_consumption = 256, # in Mbytes
  $interned_strings_buffer = 128, # in Mbytes
  $max_accelerated_files = 4000,
  $fast_shutdown = true,
  $validate_timestamps = false
) {

  require 'php5'

  exec { 'Remove all symlinks to opcache':
    command   => 'find /etc/php5 -name 05-opcache.ini -delete',
    path      => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider  => shell,
    onlyif    => 'find /etc/php5/ -name 05-opcache.ini | grep -q 05-opcache.ini',
    require   => Php5::Config_extension['opcache'],
  }

  php5::config_extension { 'opcache':
    content => template("${module_name}/extension/opcache/conf.ini"),
  }

  file { "/opt/php5/opcache-status.php":
    ensure  => file,
    content => template("${module_name}/extension/opcache/opcache-status.php"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }

  Php5::Fpm::With_opcache <||>
}
