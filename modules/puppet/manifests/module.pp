define puppet::module ($version = '>v0.0.0', $update = true) {

  if $update {
    exec {"puppet module upgrade $name":
      command => "puppet module upgrade ${name}",
      onlyif => "puppet module list | grep ${name}",
      path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    }
  }

  exec {"puppet module install $name":
    command => "puppet module install -f -v '${version}' ${name}",
    unless => "puppet module list | grep ${name}",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
}
