class base::tools {

  require 'vim'
  require 'rsync'

  package {['unp', 'screen', 'parallel', 'sysstat', 'zip', 'htop', 'iftop', 'iotop', 'tree', 'nethogs', 'strace', 'links']:
    ensure => present,
  }
}
