class raid::hwraid-le-vert {

  apt::source {'hwraid-le-vert':
    entries => [ "deb http://hwraid.le-vert.net/debian ${::lsbdistcodename} main" ],
    keys => {
      'le-vert' => {
        key     => '23B3D3B4',
        key_url => 'http://hwraid.le-vert.net/debian/hwraid.le-vert.net.gpg.key',
      }
    }
  }
}
