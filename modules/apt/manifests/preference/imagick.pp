class apt::preference::imagick (
  $version = '8:6.8.9.9-5+deb8u2'
) {

  apt::preference { ['imagemagick-common', 'libmagickcore-6.q16-2', 'libmagickwand-6.q16-2']:
    pin => "version ${version}",
  }
}
