class satis($hostname) {

  require 'composer'
  require 'git'

  $version = 'b20fd944ec40ad65c1e54bb0860fe844f4efd56e' # 1.0.0-alpha1

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
