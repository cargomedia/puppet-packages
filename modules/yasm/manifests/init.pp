class yasm ($version = '1.2.0'){

  require 'build'

  helper::script {'install yasm':
    content => template('yasm/install.sh'),
    unless => "yasm --version | grep -q '^yasm ${version}$'",
  }

}
