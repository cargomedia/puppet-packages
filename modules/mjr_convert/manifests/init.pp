class mjr_convert {

  require 'janus::common'
  require 'ffmpeg'

  file { '/usr/bin/mjr2webm':
    ensure  => 'file',
    owner   => '0',
    group   => '0',
    content => template("${module_name}/mjr2webm.sh"),
    mode    => '0755',
  }

  file { '/usr/bin/mjr2png':
    ensure  => 'file',
    owner   => '0',
    group   => '0',
    content => template("${module_name}/mjr2png.sh"),
    mode    => '0755',
  }
}
