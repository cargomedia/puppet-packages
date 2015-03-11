node default {

  class { 'monit': }
  class { 'monit::entry::system': }

  monit::entry { 'foo':
    content => 'CHECK PROCESS foo MATCHING "init"',
  }
}
