class ufw {

  require 'apt'
  include 'ufw::service'

  package { 'ufw':
    ensure   => present,
    provider => 'apt',
  }

  file {
    '/etc/ufw/applications.d':
      ensure  => directory,
      owner   => '0',
      group   => '0',
      mode    => '0644',
      purge   => true,
      recurse => true;
    '/etc/ufw/before.d':
      ensure  => directory,
      owner   => '0',
      group   => '0',
      mode    => '0644',
      purge   => true,
      recurse => true;
    '/etc/ufw/before.d/default-dist':
      ensure  => file,
      content => template("${module_name}/default-dist.rules.erb"),
      owner   => '0',
      group   => '0',
      mode    => '0644',
      notify  => Class['ufw::service'];
    '/var/log/ufw':
      ensure  => directory,
      owner   => '0',
      group   => '0',
      mode    => '0644';
    '/var/log/ufw/ufw.log':
      ensure  => file,
      owner   => '0',
      group   => '0',
      mode    => '0644',
      before  => Rsyslog::Config['20-ufw'];
    '/etc/ufw/before.d/private-network-allow':
      ensure  => file,
      content => template("${module_name}/private-network-allow.rules.erb"),
      owner   => '0',
      group   => '0',
      mode    => '0644',
      notify  => Class['ufw::service'];
  }

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
