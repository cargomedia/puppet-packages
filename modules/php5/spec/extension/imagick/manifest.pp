node default {

  class { 'php5::extension::imagick':
    ini_content => "extension=imagick.so\nimagick.progress_monitor=true\n",
  }
}
