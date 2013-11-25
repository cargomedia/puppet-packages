node default {

  require 'apt::update'

  class {'php5::extension::imagick':}
}
