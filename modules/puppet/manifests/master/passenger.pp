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
  }
  ->

  exec {
    'copy puppet rack config file':
      command => 'sudo cp /usr/share/puppet/ext/rack/config.ru /usr/share/puppet/rack/puppetmasterd/',
      path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'];

    'chown config file by puppet:puppet':
      command => 'sudo chown puppet:puppet /usr/share/puppet/rack/puppetmasterd/config.ru',
      path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'];
  }

  apache2::vhost {'puppetmaster':
    content => template('puppet/master/apache2/vhost'),
    notify => Service['apache2'],
  }

}
