class needrestart (
  $restart_helper_path = '/usr/local/bin/needrestart-service'
){

  $is_wheezy = ($::facts['lsbdistcodename'] == 'wheezy')

  if $is_wheezy {
    require 'apt::source::backports'
  }

  package { 'needrestart':
    provider => apt
  }

  file { $restart_helper_path:
    ensure  => file,
    content => template("${module_name}/needrestart.sh.erb"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }
}
