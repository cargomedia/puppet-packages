class mjr2webm {

  require 'janus'
  require 'ffmpeg'

  file { '/usr/bin/mjr2webm':
    ensure  => 'file',
    owner   => '0',
    group   => '0',
    content => template('mjr2webm/script.sh'),
    mode    => '0755',
  }
}
