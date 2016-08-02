node default {

  $hosts = get_knownhosts('foo')

  file { '/tmp/results_from_custom_func':
    content => inline_template("<%= @hosts.join('\n') + \"\n\" %>"),
  }
}
