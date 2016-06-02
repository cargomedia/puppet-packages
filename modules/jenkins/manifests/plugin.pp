define jenkins::plugin($version) {

  require 'unzip'
  require 'jenkins'
  include 'jenkins::service'

  exec { "install jenkins plugin ${name}":
    command => "/var/lib/jenkins/installPlugin.sh '${name}' '${version}'",
    path    => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless  => "grep 'Plugin-Version: ${version}' /var/lib/jenkins/plugins/${name}/META-INF/MANIFEST.MF",
    user    => 'jenkins',
    notify  => Service['jenkins'],
  }

}
