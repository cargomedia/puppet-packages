class ufw {

  require 'apt'
  include 'ufw::service'

  package { 'ufw':
    ensure   => present,
    provider => 'apt',
  }

<<<<<<< HEAD
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
=======
  file {
    '/etc/ufw/applications.d':
      ensure  => directory,
      owner   => '0',
      group   => '0',
      mode    => '0644',
      purge   => true,
      recurse => true,
      require => Package['ufw'];
    '/etc/ufw/before.d':
      ensure  => directory,
      owner   => '0',
      group   => '0',
      mode    => '0644',
      purge   => true,
      recurse => true,
      require => Package['ufw'];
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
>>>>>>> bd82cf0... add dependencies
  }

  ufw::rules::before {['00-default_dist', '10-private_network_allow']:
    require => [File['/etc/ufw/before.d'], Package['ufw']],
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
