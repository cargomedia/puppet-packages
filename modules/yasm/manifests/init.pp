class yasm ($version = '1.2.0'){

  require 'build'

  helper::script {'install yasm':
    content => template('yasm/install.sh'),
    unless => "yasm --version 2>/dev/null | grep -q 'yasm ${version}'",
  }

}
