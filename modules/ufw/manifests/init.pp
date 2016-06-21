class ufw {

  require 'apt'
  include 'ufw::service'

  package { 'ufw':
    ensure   => present,
    provider => 'apt',
  }

  $rsyslog_stop_command = $::facts['lsbdistcodename'] ? {
    'wheezy' => '~',
    default => 'stop',
  }

  file { '/etc/ufw/applications.d':
    ensure  => directory,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    purge   => true,
    recurse => true,
  }

  file { '/var/log/ufw':
    ensure  => directory,
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }

  file { '/var/log/ufw/ufw.log':
    ensure  => file,
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }
  ->

  rsyslog::config { '20-ufw':
    content => template("${module_name}/rsyslog.erb"),
  }

  logrotate::entry { $module_name:
    path              => '/var/log/ufw/ufw.log',
    rotation_newfile  => 'create 0644',
    postrotate_script => '/etc/init.d/rsyslog rotate > /dev/null 2>&1 || true',
  }

  Ufw::Application <| |> -> Exec['Activate ufw']
  Ufw::Rule <| |> -> Exec['Activate ufw']
}
