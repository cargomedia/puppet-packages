class pulseaudio (
  $autospawn = false,
){

  require 'apt'

  package { 'pulseaudio':
    provider => apt,
  }

  file { '/etc/pulse/client.conf':
    ensure  => file,
    content => template("${module_name}/client"),
    mode    => '0644',
    owner   => 0,
    require => Package['pulseaudio'],
  }

}
