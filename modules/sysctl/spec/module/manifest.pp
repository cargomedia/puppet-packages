node default {
  class {'sysctl':
    entries => {
      "net.ipv4.tcp_syncookies" => "1",
      "net.ipv4.tcp_synack_retries" => "2",
      "vm.swappiness" => "0",
    }
  }
}
