class apt::source::mysql {

  apt::source { 'mysql':
    entries => [
      'deb http://repo.mysql.com/apt/debian jessie mysql-5.6',
    ],
    keys    => {
      'mongodb' => {
        'key'        => '5072E1F5',
        'key_server' => 'hkp://pgp.mit.edu:80',
      }
    },
  }
}