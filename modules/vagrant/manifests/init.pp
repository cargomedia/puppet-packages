class vagrant {

  $version = '1.5.0'
  $url = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.5.0_x86_64.deb'

  helper::script {'install vagrant':
    content => template('vagrant/install.sh'),
    unless => "vagrant --version | grep '^Vagrant ${version}$'",
    environment => ['HOME=/tmp'],   # Vagrant needs $HOME (https://github.com/mitchellh/vagrant/issues/2215)
  }
}
