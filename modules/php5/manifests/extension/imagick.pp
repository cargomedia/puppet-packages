class php5::extension::imagick (
  $version = '3.1.2'
) {

  require 'apt'
  require 'php5'

  $imagemagick_dir = '/etc/ImageMagick-6'

  package { ['php5-imagick', 'libmagickcore-6.q16-2-extra']:
    ensure   => present,
    provider => 'apt',
    before   => [Php5::Config_extension['imagick'], File["${imagemagick_dir}/policy.xml"]]
  }

  file { "${imagemagick_dir}/policy.xml":
    ensure  => file,
    content => template("${module_name}/extension/imagick/policy.xml"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }

  php5::config_extension { 'imagick':
    content => template("${module_name}/extension/imagick/conf.ini"),
  }
}
