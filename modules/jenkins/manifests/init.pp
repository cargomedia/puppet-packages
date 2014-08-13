class jenkins(
  $hostname,
  $port = 8080,
  $emailAdmin = 'root@localhost',
  $emailSuffix = '@localhost'
) {

  require 'jenkins::package'
  include 'jenkins::service'
  include 'jenkins::config'

  file {'/var/lib/jenkins/plugins':
    ensure => 'directory',
    owner => 'jenkins',
    group => 'nogroup',
    mode => '0755',
  }

  file {'/var/lib/jenkins/jobs':
    ensure => 'directory',
    owner => 'jenkins',
    group => 'nogroup',
    mode => '0755',
  }

  file {'/etc/default/jenkins':
    ensure => file,
    content => template('jenkins/default'),
    owner => '0',
    group => '0',
    mode => '0644',
    notify => Service['jenkins'],
  }

}
