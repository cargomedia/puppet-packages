define vagrant::plugin(
  $version = undef
) {

  require 'vagrant'

  if ($version) {
    $listOutput = "${name} (${version})"
  } else {
    $listOutput = "${name}"
  }

  exec {"install vagrant plugin ${name}":
    command => "vagrant plugin install '${name}'",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless => "vagrant plugin list | grep -w '${listOutput}'",
    environment => ['HOME=/root'],   # Vagrant needs $HOME (https://github.com/mitchellh/vagrant/issues/2215)
  }
}
