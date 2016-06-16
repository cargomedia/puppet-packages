node default {

  @monit::entry { 'filesystem':
    content => 'check filesystem root with path /'
  }

}
