class php5::extension::imagick (
  $version = '3.1.2',
  $ini_content = 'extension=imagick.so'
) {

  require 'apt'
  require 'php5'

  if $::lsbdistcodename == 'wheezy' {
    require 'build'

    package { 'libmagickwand-dev':
      ensure   => present,
      provider => 'apt',
    }
    ->

    helper::script { 'install php5::extension::imagick':
      content => template("${module_name}/extension/imagick/install.sh"),
      unless  => "php --re imagick | grep -w 'imagick version ${version}'",
      require => Class['php5'],
    }

  } else {
    package { 'php5-imagick':
      ensure   => present,
      provider => 'apt',
    }
  }

  php5::config_extension { 'imagick':
    content => $ini_content,
  }
}
