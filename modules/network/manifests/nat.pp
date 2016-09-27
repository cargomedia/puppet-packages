class network::nat (
  $ifname_public,
  $ifname_private,
  $to_source,
) {

  require 'ufw'

  sysctl::entry { 'ip4_forward':
    entries => {
      'net.ipv4.ip_forward' => '1',
    }
  }

  file {
    '/etc/ufw/before.d':
      ensure  => directory,
      owner   => '0',
      group   => '0',
      mode    => '0644',
      notify  => Exec['Rebuild before.rules'];
    '/etc/ufw/before.d/snat':
      ensure  => file,
      content => template("${module_name}/snat.rules.erb"),
      owner   => '0',
      group   => '0',
      mode    => '0644',
      notify  => Class['ufw::service'];
    '/etc/ufw/before.d/default-dist':
      ensure  => file,
      content => template("${module_name}/default-dist.rules.erb"),
      owner   => '0',
      group   => '0',
      mode    => '0644',
      notify  => Class['ufw::service'];
  }

}
