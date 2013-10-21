define puppet::module ($version = '') {

  if $version == '' {
    $version_install = '>v0.0.0'
  } else {
    $version_install = $version
  }

  exec {"puppet module upgrade $name":
    command => "puppet module upgrade -f --version='${version_install}' ${name}",
    onlyif => "puppet module list | grep ${name}",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
  ->

  exec {"puppet module install $name":
    command => "puppet module install -f -v '${version_install}' ${name}",
    unless => "puppet module list | grep ${name}.*${version}",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
}
