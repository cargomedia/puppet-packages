class ffmpeg ($version = '1.0') {

  require 'deb-multimedia'
  require 'yasm'
  require 'x264'

  package {[
      'liba52-0.7.4-dev',
      'libdts-dev',
      'libgsm1-dev',
      'libfaac-dev',
      'libsdl1.2-dev',
      'libspeex-dev',
      'mjpegtools',
      'libgpac-dev',
      'libxfixes-dev',
      'zlib1g-dev',
      'libvpx-dev',
      'libvdpau-dev',
      'libopencore-amrnb-dev',
      'libopencore-amrwb-dev'
    ]:
    ensure => present,
  }
  ->

  helper::script {'install ffmpeg':
    content => template('ffmpeg/install.sh'),
    unless => "ffmpeg -version | grep -q '^ffmpeg version ${version}$'",
    timeout => 900,
  }

}
