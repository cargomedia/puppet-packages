node default {

  require 'apt::update'

  class {'puppet::common':}
}
