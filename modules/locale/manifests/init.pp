class locale {

  file { '/etc/default/locale':
    content => template("${module_name}/locale"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }
}
