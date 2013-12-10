define bipbip::entry (
  $plugin,
  $options
){

  require 'bipbip'

  file {"/etc/bipbip/services.d/${name}.yml":
    ensure => file,
    content => template('bipbip/service'),
    owner => 'bipbip',
    group => 'bipbip',
    mode => '0644',
    notify => Service['bipbip'],
  }

}
