class env {

  file { '/etc/environment':
    ensure => file,
    group  => '0',
    owner  => '0',
    mode   => '0644',
  }
}
