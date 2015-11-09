node default {

  package{'wamerican':}
  ->

  class { 'janus::deps::libsrtp':
    build_tests => true,
  }
}
