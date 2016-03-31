class ufw {

  require 'apt'
  include 'ufw::service'

  package { 'ufw':
    ensure   => present,
    provider => 'apt',
  }

  $rsyslog_stop_command = $::lsbdistcodename ? {
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

  $logrotate_additional = '
	postrotate
		/etc/init.d/rsyslog rotate > /dev/null 2>&1 || true
	endscript
'

  logrotate::entry{ $module_name:
    path              => '/var/log/ufw/ufw.log',
    rotation_newfile  => 'create 644',
    additional_config => $logrotate_additional,
    require           => [File['/var/log/ufw'],Rsyslog::Config['20-ufw']],
  }

  Ufw::Application <| |> -> Exec['Activate ufw']
  Ufw::Rule <| |> -> Exec['Activate ufw']
}
