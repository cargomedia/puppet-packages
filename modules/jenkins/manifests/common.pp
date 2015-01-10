class jenkins::common {

  include 'ntp'

  user {'jenkins':
    ensure => present,
    system => true,
    managehome => true,
    home => '/var/lib/jenkins',
  }

}
