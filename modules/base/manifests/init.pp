class base {

  case $::operatingsystem {
    Debian: {
      require 'apt'
      require 'apt::cron-apt'
    }
  }
  require '::bash'
  require '::ssh'
  require '::postfix'
  require '::ulimit'
  require '::cron'
  require '::raid'
  require '::base::monit'
  require '::base::rsyslog'
  require '::base::tools'

  Exec {
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
}
