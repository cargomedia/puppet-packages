class cron {

  monit::entry {'cron':
    content => template('cron/monit'),
  }
}
