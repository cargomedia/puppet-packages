class virtualbox {

  apt::source {'virtualbox':
    entries => [
      'deb http://download.virtualbox.org/virtualbox/debian squeeze contrib non-free',
    ],
    keys => {
      'nginx' => {
        key     => '98AB5139',
        key_url => 'http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc',
      }
    }
  }
  ->

  package {'virtualbox-4.3':
    ensure => present,
  }

  package {'dkms':
    ensure => present,
  }
}
