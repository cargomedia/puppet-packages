class virtualbox {

  require 'apt'

  apt::source { 'virtualbox':
    entries => [
      "deb http://download.virtualbox.org/virtualbox/debian ${::lsbdistcodename} contrib non-free",
    ],
    keys    => {
      'virtualbox' => {
        key     => '98AB5139',
        key_url => 'http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc',
      }
    }
  }
  ->

  package { 'virtualbox-5.0':
    ensure => present,
    provider => 'apt',
  }

  package { 'dkms':
    ensure => present,
    provider => 'apt',
  }
}
