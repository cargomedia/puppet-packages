node default {

  apt::preference { 'imagemagick-common':
    pin          => 'version 8:6.8.9.9-5+deb8u2',
    pin_priority => 1000,
  }
}
