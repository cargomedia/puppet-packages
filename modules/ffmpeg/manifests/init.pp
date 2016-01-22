class ffmpeg ($version = '2.6') {

  require 'apt'
  require 'deb_multimedia'
  require 'yasm'
  require 'x264'
  require 'build::dev::zlib1g'

  package { [
    'liba52-0.7.4-dev',
    'libdts-dev',
    'libgsm1-dev',
    'libfaac-dev',
    'libsdl1.2-dev',
    'libspeex-dev',
    'mjpegtools',
    'libgpac-dev',
    'libxfixes-dev',
    'libvpx-dev',
    'libopus-dev',
    'libvdpau-dev',
    'libopencore-amrnb-dev',
    'libopencore-amrwb-dev'
  ]:
    ensure   => present,
    provider => 'apt',
  }
  ->

  helper::script { 'install ffmpeg':
    content => template("${module_name}/install.sh"),
    unless  => "ffmpeg -version | grep -q '^ffmpeg version ${version} '",
    timeout => 900,
  }
  ->

  # Workaround until we have a DEB for ffmpeg - https://github.com/cargomedia/debian-packages/issues/82
  file { '/usr/bin/ffmpeg':
    ensure => link,
    target => '/usr/local/bin/ffmpeg',
  }

}
