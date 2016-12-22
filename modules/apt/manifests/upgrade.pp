class apt::upgrade(
) {

  include 'apt::update'

  exec { 'apt_upgrade':
    command     => '/usr/bin/apt-get -y -o Dpkg::Options::="--force-confold" dist-upgrade',
    user        => 'root',
    environment => ['DEBIAN_FRONTEND=noninteractive'],
    refreshonly => true,
    subscribe   => Exec['apt_update'],
  }

}
