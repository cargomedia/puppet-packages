class yasm ($version = '1.2.0'){

  helper::script {'install yasm':
    content => template('yasm/install.sh'),
    unless => 'test -x /usr/local/bin/yasm',
  }

}
