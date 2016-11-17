node default {

  class { 'squid_deb_proxy': }

  # Download some deb's to populate the cache
  exec { 'Install some packages':
    provider => shell,
    command  => 'apt-get -y install fontconfig bzip2 htop',
    path     => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }

  # Remove them
  ensure_packages(['fontconfig', 'bzip2', 'htop'], { ensure => 'purged', provider => 'apt' })

  exec { 'Clean apt cache with apt-get clean':
    provider => shell,
    command  => 'apt-get clean',
    path     => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require  => Exec['Install some packages'],
  }
}
