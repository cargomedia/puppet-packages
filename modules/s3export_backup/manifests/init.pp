class s3export_backup {

  require 'cm::application'

  composer::project{ 'cargomedia/s3export_backup':
    version   => '0.1.1',
    stability => 'dev',
  }
  ->

  file { '/usr/local/bin/s3export':
    content => template('s3export_backup/s3export.sh'),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }
}
