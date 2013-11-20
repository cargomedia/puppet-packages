node default {

  class {'backup::server':
    type => 'rdiff'
  }

}