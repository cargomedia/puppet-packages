node default {

  sysctl::entry { 'network':
    entries => {
      'net.ipv4.tcp_max_syn_backlog' => '1024',
    }
  }
}
