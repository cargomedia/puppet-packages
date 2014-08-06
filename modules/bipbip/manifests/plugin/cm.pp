class bipbip::plugin::cm(
  $version = '0.1.0'
) {

  require 'bipbip'

  ruby::gem {'bipbip-cm':
    ensure => $version,
  }

}
