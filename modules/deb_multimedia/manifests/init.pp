class deb_multimedia {

  require 'apt'

  apt::source { 'deb-multimedia':
    entries => [ "deb http://www.deb-multimedia.org ${::lsbdistcodename} main non-free" ],
    keys    => {
      'debian-multimedia' => {
        key        => '65558117',
        key_server => 'keyserver.ubuntu.com',
      }
    }
  }
  ->

  package { 'deb-multimedia-keyring':
    ensure   => latest,
    provider => 'apt',
  }

}
