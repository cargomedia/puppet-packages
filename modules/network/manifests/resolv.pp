class network::resolv (
  $nameserver = [],
  $search     = [],
  $domain     = '',
) {

  file { '/etc/resolv.conf':
    ensure  => file,
    content => template("${module_name}/resolv.conf"),
  }
}
