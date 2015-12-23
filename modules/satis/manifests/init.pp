class satis($hostname) {

  require 'composer'
  require 'git'

  $version = '68ba9149b30da77ab6d8b37712e5a7d531c5a5f4'

  file { '/etc/satis':
    ensure => 'directory',
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  user { 'satis':
    ensure     => present,
    system     => true,
    managehome => true,
    home       => '/var/lib/satis',
  }
  ->

  composer::project { 'composer/satis':
    target    => '/var/lib/satis/satis',
    version   => $version,
    stability => 'dev',
    user      => 'satis',
    home      => '/var/lib/satis'
  }
  ->

  file { '/var/lib/satis/public':
    ensure => 'directory',
    owner  => 'satis',
    group  => 'satis',
    mode   => '0755',
  }
  ->

  apache2::vhost{ $hostname:
    content => template("${module_name}/vhost"),
  }
}
