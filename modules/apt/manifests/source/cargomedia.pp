class apt::source::cargomedia {

  apt::source {'cargomedia':
    entries => [
      "deb http://debian-packages.cargomedia.ch ${::lsbdistcodename} main",
    ],
    keys => {
      'cargomedia' => {
        'key' => '4A45CD8B',
        'key_url' => 'http://debian-packages.cargomedia.ch/conf/signing.key',
      }
    },
  }
}
