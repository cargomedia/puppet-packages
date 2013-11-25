class jenkins(
  $hostname,
  $emailAdmin = 'root@localhost',
  $emailSuffix = '@localhost'
) {

  $port = 8080

  require 'jenkins::package'
  include 'jenkins::service'
  include 'jenkins::config'

  file {'/var/lib/jenkins/plugins':
    ensure => 'directory',
    owner => 'jenkins',
    group => 'nogroup',
    mode => '0755',
  }

  class{'jenkins::plugin::build-name-setter':}

}
