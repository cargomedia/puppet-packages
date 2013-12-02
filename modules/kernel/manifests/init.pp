class kernel(
  $modules = ['loop']
) {

  file { '/etc/modules':
    ensure => file,
    owner => '0',
    group => '0',
    mode => '0644',
    content => template('kernel/modules')
  }
}
