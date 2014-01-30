class deb-multimedia {

  apt::source {'deb-multimedia':
    entries => [ "deb http://www.deb-multimedia.org ${::lsbdistcodename} main non-free" ],
    keys => {
      'debian-multimedia' => {
        key => '1F41B907',
        key_content => template('deb-multimedia/debian-multimedia-keyring.gpg'),
      }
    }
  }
  ->

  package {'deb-multimedia-keyring':
    ensure => latest,
  }

}
