node default {

  class { 'rsyslog':
    logfile_mode => '0707',
  }
}
