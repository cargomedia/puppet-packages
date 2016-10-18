class jenkins::service {

  $port = $jenkins::port

  require 'jenkins::package'

  service { 'jenkins':
    enable => true,
  }
  
  @systemd::critical_unit { 'jenkins.service': }
}
