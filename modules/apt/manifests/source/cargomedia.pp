class apt::source::cargomedia {

  apt::source { 'cargomedia':
    entries => [
      "deb [arch=amd64] http://debian-packages.cargomedia.ch ${::facts['lsbdistcodename']} main",
    ],
    keys    => {
      'cargomedia' => {
        'key' => '4A45CD8B',
        'key_url' => 'http://debian-packages.cargomedia.ch/conf/signing.key',
      }
    },
  }
}
