class needrestart (
  $restart_helper_path = '/usr/local/bin/needrestart-service',
  $apt_invoke = false,
){

  package { 'needrestart':
    provider => apt,
  }

  file { $restart_helper_path:
    ensure  => file,
    content => template("${module_name}/needrestart.sh.erb"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }

  if $apt_invoke == false {
    file { '/etc/apt/apt.conf.d/99needrestart':
      ensure  => absent,
      require => Package['needrestart'],
    }
  }
}
