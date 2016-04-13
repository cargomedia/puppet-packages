class ffmpeg {


  if $::lsbdistcodename == 'jessie' {
    require 'apt::source::backports'
    $package_name = 'ffmpeg'
  } else {
    require 'apt::source::cargomedia'
    $package_name = 'ffmpeg-cm'
  }

  package { $package_name:
    ensure   => present,
    provider => 'apt',
  }
}
