define nodejs::package(
  $path,
  $version,
  $user = 'root',
) {

  require 'nodejs'

  $npm_path = 'npm'

  $install_check_package_string = "${name}:${name}@${ensure}"
  $install_check = "${npm_path} ls --long --parseable | grep '${path}/node_modules/${install_check_package_string}'"

  $package_string = "${name}@${version}"

  exec { "npm_install_${name}":
    command     => "${npm_path} install ${package_string}",
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless      => $install_check,
    user        => $user,
    cwd         => $path,
    require     => Class['nodejs'],
  }

}
