class puppet::master::passenger (
  $port = 8140
){

  require '::passenger'
  require 'apache2::mod::ssl'
  require 'apache2::mod::headers'

  file {
    ['/usr/share/puppet', '/usr/share/puppet/rack/', '/usr/share/puppet/rack/puppetmasterd']:
      ensure => directory,
      owner => 'puppet',
      group => 'puppet',
      mode => 0755;

    ['/usr/share/puppet/rack/puppetmasterd/public', '/usr/share/puppet/rack/puppetmasterd/tmp']:
      ensure => directory,
      owner => 'puppet',
      group => 'puppet',
      mode => 0755;

    '/usr/share/puppet/rack/puppetmasterd/config.ru':
      ensure => present,
      source => '/usr/share/puppet/ext/rack/config.ru',
      owner => 'puppet',
      group => 'puppet',
      mode => 0755;
  }
  ->

  apache2::vhost {'puppetmaster':
    content => template('puppet/master/apache2/vhost'),
  }

}
