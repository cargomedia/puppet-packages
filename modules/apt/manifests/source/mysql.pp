class apt::source::mysql {

  apt::source { 'mysql':
    entries => [
      'deb http://repo.mysql.com/apt/debian jessie mysql-5.7',
    ],
    keys    => {
      'mysql' => {
        'key'        => '5072E1F5',
        'key_server' => 'hkp://ha.pool.sks-keyservers.net:80',
      }
    },
  }
}