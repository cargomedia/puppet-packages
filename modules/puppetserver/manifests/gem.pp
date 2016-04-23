define puppetserver::gem {

  include 'puppetserver'

  package { "${title} (puppetserver)":
    name     => $title,
    ensure   => present,
    provider => puppetserver_gem,
    require  => Package['puppetserver'],
    notify   => Service['puppetserver'],
  }

}
