node default {

  class { 'squid_deb_proxy': }

  # Download some deb's to populate the cache
  exec { 'Install packages':
    provider => shell,
    command  => 'apt-get -o Acquire::http::Proxy="http://localhost:8124/" -y install fontconfig bzip2 htop',
    path     => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }

  # Remove them
  ensure_packages(['fontconfig', 'bzip2', 'htop'], {
    ensure => 'purged',
    provider => 'apt',
    require => Exec['Install packages'],
    before => Exec['Clean apt cache']
  })

  # Clean cache
  exec { 'Clean apt cache':
    provider => shell,
    command  => 'apt-get autoclean && apt-get clean',
    path     => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require  => Exec['Install packages'],
  }
}
