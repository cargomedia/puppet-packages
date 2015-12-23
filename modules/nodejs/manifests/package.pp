define nodejs::package(
  $path,
  $version = 'latest',
  $user = 'root',
  $home = '/root',
) {

  require 'nodejs'

  $npm_path = 'npm'

  if $version == 'latest' {
    $install_check_package_string = "${name}:${name}@\$(${npm_path} view ${name} version --quiet)"
  } else {
    $install_check_package_string = "${name}:${name}@${version}"
  }
  $install_check = "${npm_path} ls --long --parseable | grep \"${path}/node_modules/${install_check_package_string}\""

  exec { "npm_install_${name}":
    command     => "${npm_path} install ${name}@${version}",
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless      => $install_check,
    user        => $user,
    environment => ["HOME=${home}"],
    cwd         => $path,
    require     => Class['nodejs'],
  }

}
