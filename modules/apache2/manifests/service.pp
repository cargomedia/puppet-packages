class apache2::service {

  require 'apache2'

  service { 'apache2':
    enable => true,
  }

  exec { 'start apache2':
    command     => '/etc/init.d/apache2 start',
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless      => '/etc/init.d/apache2 status',
    refreshonly => true,
    require     => Service['apache2'],
  }

  @monit::entry { 'apache2':
    content => template("${module_name}/monit"),
    require => Service['apache2'],
  }
}
