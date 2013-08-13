class base {

  case $operatingsystem {
    Debian: {
      require 'cron-apt'
      require 'apt::sources'
    }
  }

  require 'bash'
  require 'ssh'
  require 'postfix'
  require 'vim'
}
