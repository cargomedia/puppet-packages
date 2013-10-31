class base {

  case $::operatingsystem {
    Debian: {
      require 'apt'
      require 'apt::cron-apt'
    }
  }
  require 'bash'
  require 'ssh'
  require 'postfix'
  require 'monit'
  require 'ulimit'
  require 'rsyslog'
}
