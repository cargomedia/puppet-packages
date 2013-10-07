define puppet::master::module() {

  exec {"puppet module install ${name}":
    command => "puppet module install ${name}",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
}
