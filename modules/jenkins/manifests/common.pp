class jenkins::common {

  include 'ntp'
  include 'java::jre_headless'

  user { 'jenkins':
    ensure     => present,
    system     => true,
    managehome => true,
    home       => '/var/lib/jenkins',
  }

}
