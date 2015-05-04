class jenkins::common {

  include 'ntp'
  include 'java'

  user { 'jenkins':
    ensure     => present,
    system     => true,
    managehome => true,
    home       => '/var/lib/jenkins',
  }

}
