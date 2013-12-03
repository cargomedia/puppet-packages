class x264 {

  require 'build'
  require 'yasm'

  helper::script {'install x264':
    content => template('x264/install.sh'),
    unless => 'test -x /usr/bin/x264',
  }

}