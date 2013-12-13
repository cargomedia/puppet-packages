class apt::source::dotdeb {

  apt::source {'dotdeb':
    entries => [
    'deb http://packages.dotdeb.org squeeze all',
    'deb-src http://packages.dotdeb.org squeeze all',
    ],
  }
}
