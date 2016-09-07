node default {

  $version = 'version 8:6.8.9.9-5+deb8u2'

  apt::preferences { 'imagemagick-common':
    pin => $version,
  }

  apt::preferences { 'libmagickcore-6.q16-2':
    pin => $version,
  }

  apt::preferences { 'libmagickwand-6.q16-2':
    pin => $version,
  }
}
