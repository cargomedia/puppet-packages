class mysql::service {

  include 'mysql::server'

  service {'mysql':
    require => Package['mysql-server'],
    hasrestart => false,
    start => '/etc/init.d/mysql start',
    stop => '/etc/init.d/mysql stop \
      || (killall -SIGTERM mysqld && timeout 10 sh -c "while (pgrep mysqld); do sleep 0.1; done")', # Workaround for https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=741286
    loglevel => debug,
  }
}
