define puppetserver::gem {

  include 'puppetserver'

  package { "${title} (puppetserver)":
    ensure   => present,
    name     => $title,
    provider => puppetserver_gem,
    require  => Package['puppetserver'],
    notify   => Service['puppetserver'],
  }

}
