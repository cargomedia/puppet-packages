class xpra (
  $xorg_conf_path = undef
) {

  package { 'xpra':
    ensure   => present,
    provider => 'apt',
  }

  $xorg_path = $xorg_conf_path ? { undef => '/etc/xpra/xorg.conf', default => $xorg_conf_path }

  if ($xorg_conf_path == undef) {

    file { $xorg_path:
      ensure   => file,
      content  => template("${module_name}/xorg"),
      mode     => '0644',
      group    => '0',
      owner    => '0',
      require  => Package['xpra']
    }
  }

  file { '/etc/xpra/xpra.conf':
    ensure   => file,
    content  => template("${module_name}/xpra"),
    mode     => '0644',
    group    => '0',
    owner    => '0',
    require  => Package['xpra']
  }

}
