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
  require '::monit::entry::system'
  require '::rsyslog'
  require '::base::tools'
}
