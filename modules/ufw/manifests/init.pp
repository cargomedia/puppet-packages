class ufw (
  $ipv6 = false,
  $ip_forward = true,
){

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
    '/etc/default/ufw':
      ensure  => file,
      content => template("${module_name}/default.ufw.erb"),
      owner   => '0',
      group   => '0',
      mode    => '0644';
    '/etc/ufw/sysctl.conf':
      ensure  => file,
      content => template("${module_name}/sysctl.conf.erb"),
      owner   => '0',
      group   => '0',
      mode    => '0644';
  }

  ufw::rules::before {['00-default_dist', '10-private_network_allow']:
    require => [File['/etc/ufw/before.d'], Package['ufw']],
  }

  Ufw::Rules::Before <| |> ~> Exec['Rebuild before.rules']
  Ufw::Application <| |> -> Exec['Activate ufw']
  Ufw::Rule <| |> -> Exec['Activate ufw']
}
