define puppet::module (
  $version
) {

  exec {"puppet module install ${name}":
    command => "puppet module install --force --version ${version} ${name}",
    unless => "puppet module list --color=false | grep '${name} (v${version})'",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
}
