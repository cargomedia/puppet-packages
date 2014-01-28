class virtualbox {

  apt::source {'virtualbox':
    entries => [
      "deb http://download.virtualbox.org/virtualbox/debian ${::lsbdistcodename} contrib non-free",
    ],
    keys => {
      'virtualbox' => {
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
