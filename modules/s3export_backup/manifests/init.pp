class s3export_backup (
  $awsKey,
  $awsSecret,
  $awsRegion,
  $awsBucket,
) {

  require 'cm::application'
  require 'truecrypt'
  require 'gdisk'

  composer::project { 'cargomedia/s3export_backup':
    version   => '0.1.1',
    stability => 'dev',
  }
  ->

  file { '/usr/local/composer/cargomedia/s3export_backup/resources/config/local.php':
    content => template('s3export_backup/config.php'),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }
  ~>

  exec { 's3export_backup setup':
    command     => '/usr/local/composer/cargomedia/s3export_backup/bin/cm app setup',
    refreshonly => true,
  }

  file { '/usr/local/bin/s3export':
    content => template('s3export_backup/s3export.sh'),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }
}
