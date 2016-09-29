node default {

  sysctl::entry { 'foo':
    entries => {
      'net.ipv4.tcp_syncookies' => '1',
      'net.core.somaxconn' => '512',
      'net.ipv4.tcp_max_syn_backlog' => '1024',
    }
  }
}
