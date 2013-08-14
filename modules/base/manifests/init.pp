class base {

  case $operatingsystem {
    Debian: {
      require 'apt::sources'
      require 'apt::cron-apt'
    }
  }

  require 'bash'
  require 'ssh'
  require 'postfix'
  require 'vim'
}
