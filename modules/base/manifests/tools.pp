class base::tools {

  require 'vim'

  package {['unp', 'screen', 'parallel', 'sysstat', 'zip', 'htop', 'iftop', 'iotop', 'tree', 'rsync']:
    ensure => installed
  }
}
