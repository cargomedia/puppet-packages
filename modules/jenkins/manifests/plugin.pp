define jenkins::plugin($version) {

  require 'jenkins'
  include 'jenkins::service'

  $path = "/var/lib/jenkins/plugins/${name}.hpi"
  $url = "http://mirrors.jenkins-ci.org/plugins/${name}/${version}/${name}.hpi"

  exec {"install jenkins plugin ${name}":
    command => "curl -sL ${url} > ${path}",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    creates => $path,
    user => 'jenkins',
    notify => Service['jenkins'],
  }
}
