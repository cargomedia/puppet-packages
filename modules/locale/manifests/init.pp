class locale($lang = 'en_US.UTF-8') {

  file { '/etc/default/locale':
    content => template("${module_name}/locale.erb"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }
}
