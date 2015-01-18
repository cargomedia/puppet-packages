class cm::application (
  $development = false
) {

  require 'composer'
  require 'php5'
  require 'php5::extension::apcu'
  require 'php5::extension::mysql'
  require 'php5::extension::redis'
  require 'php5::extension::intl'
  require 'php5::extension::memcache'
  require 'php5::extension::gd'
  require 'php5::extension::imagick'
  require 'php5::extension::curl'
  require 'php5::extension::runkit'
  require 'php5::extension::stats'
  require 'php5::extension::svm'
  require 'php5::extension::mcrypt'
  require 'php5::extension::gearman'
  require 'php5::extension::mongo'
  require 'php5::fpm'
  require 'uglify'
  require 'autoprefixer'
  require 'foreman::debian'
  require 'mysql::client'

  class {'php5::extension::opcache':
    enable => !$development,
  }

  if $development {
    require 'php5::extension::xdebug'
  }
}
