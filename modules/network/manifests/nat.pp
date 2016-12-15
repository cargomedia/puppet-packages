class network::nat (
  $ifname_public,
  $ifname_private,
  $to_source,
) {

  include 'ufw'

  sysctl::entry { 'ip4_forward':
    entries => {
      'net.ipv4.ip_forward' => '1',
    }
  }

  ufw::rules::before { '20-snat':
    rules_content => template("${module_name}/20-snat.rules.erb"),
  }
}
