class ffmpeg ($version = '1.0') {

  require 'deb-multimedia'

  package {['liba52-dev', 'libdts-dev', 'libgsm1-dev', 'libfaac-dev', 'libsdl1.2-dev', 'libspeex-dev', 'mjpegtools', 'libgpac-dev',
            'libxfixes-dev', 'zlib1g-dev', 'libvpx-dev', 'libvdpau-dev', 'libopencore-amrnb-dev', 'libopencore-amrwb-dev']:
    ensure => present,
  }
  ->

  helper::script {'install ffmpeg':
    content => template('ffmpeg/install.sh'),
    unless => "test -x /usr/local/bin/ffmpeg && (ffmpeg -version 2>/dev/null | grep -q '^ffmpeg version ${version}$')",
    timeout => 900,
  }

}
