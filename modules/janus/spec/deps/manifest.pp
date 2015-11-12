node default {

  class { [
    'janus::deps::libsrtp',
    'janus::deps::libusrsctp',
    'janus::deps::libwebsockets',
  ]: }

}
