node default {

  sysctl::entry {'foo':
    entries => {
      'net.ipv4.tcp_syncookies' => '1',
    }
  }
}
