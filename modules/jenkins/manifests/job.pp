define jenkins::job($content) {

  require 'jenkins'
  include 'jenkins::service'

  file {"/var/lib/jenkins/jobs/${name}":
    ensure => 'directory',
    owner => 'jenkins',
    group => 'nogroup',
    mode => '0644',
  }

  file {"/var/lib/jenkins/jobs/${name}/config.xml":
    ensure => 'file',
    content => $content,
    owner => 'jenkins',
    group => 'nogroup',
    mode => '0644',
    notify => Service['jenkins'],
  }
}
