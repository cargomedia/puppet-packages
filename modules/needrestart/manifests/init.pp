class needrestart (
  $restart_helper_path = '/usr/local/bin/needrestart-service',
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

  # This will disable all services restart after upgrade
  file { '/etc/apt/apt.conf.d/99needrestart':
    ensure  => absent,
    require => Package['needrestart'],
  }
}
