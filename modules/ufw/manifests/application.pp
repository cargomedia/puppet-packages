define ufw::application(
  $app_name = $title,
  $app_title = $title,
  $app_description = $title,
  $app_ports,
  $auto_allow = true
){

  require 'ufw'

  file { "/etc/ufw/applications.d/${app_name}" :
    ensure  => file,
    content => template("${module_name}/application.erb"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }
  ~>

  exec { "Refresh rule for ${app_name}":
    provider    => shell,
    command     => "ufw app update ${app_name}",
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user        => 'root',
    refreshonly => true,
    notify      => Service['ufw'],
  }

  if $auto_allow {
    ufw::rule { "Allow ${app_name}":
      app_or_port => $app_name,
      require     => Exec["Refresh rule for ${app_name}"],
    }
  }
}
