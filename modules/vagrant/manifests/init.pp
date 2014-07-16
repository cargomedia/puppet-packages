class vagrant {

  $version = '1.6.3'
  $url = 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_64.deb'

  helper::script {'install vagrant':
    content => template('vagrant/install.sh'),
    unless => "vagrant --version | grep '^Vagrant ${version}$'",
    environment => ['HOME=/tmp'],   # Vagrant needs $HOME (https://github.com/mitchellh/vagrant/issues/2215)
  }
}
