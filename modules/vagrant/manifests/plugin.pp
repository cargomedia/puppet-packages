define vagrant::plugin(
  $user,
  $user_home,
  $version = undef
) {

  require 'vagrant'

  if ($version) {
    $listOutput = "${name} (${version})"
    $installCommand = "vagrant plugin install '${name}' --plugin-version '${version}'"
  } else {
    $listOutput = $name
    $installCommand = "vagrant plugin install '${name}'"
  }

  exec { "install vagrant plugin ${name}":
    command     => $installCommand,
    user        => $user,
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless      => "vagrant plugin list | grep -w '${listOutput}'",
    environment => ["HOME=${user_home}"],   # Vagrant needs $HOME (https://github.com/mitchellh/vagrant/issues/2215)
    cwd         => $user_home,
  }
}
