class apt::source::dotdeb {

  apt::source {'dotdeb':
    entries => [
    'deb http://packages.dotdeb.org squeeze all',
    'deb-src http://packages.dotdeb.org squeeze all',
    ],
    keys => {
      'dotdeb' => {
        'key' => '89DF5277',
        'key_url' => 'http://www.dotdeb.org/dotdeb.gpg',
      }
    },
  }
}
