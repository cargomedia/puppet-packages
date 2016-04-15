node default {

  class { 'postgresql::server':
    port => 1234
  }

}
