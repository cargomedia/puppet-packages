class vagrant {

  $version = '1.3.5'
  $url = 'http://files.vagrantup.com/packages/a40522f5fabccb9ddabad03d836e120ff5d14093/vagrant_1.3.5_x86_64.deb'

  include 'nfs::server' # For nfs shares

  helper::script {'install vagrant':
    content => template('vagrant/install.sh'),
    unless => "test -e /opt/vagrant/bin/vagrant && /opt/vagrant/bin/vagrant --version | grep -q '^Vagrant ${version}$'",
  }
}
