define kernel::modprobe_blacklist(
  $modules
) {

  kernel::modprobe{ "blacklist-${title}":
    content => template("${module_name}/modprobe_blacklist.erb")
  }
  ~>

  exec { "unload modules for blacklist ${title}":
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider    => shell,
    command     => template("${module_name}/unload_modules.sh.erb"),
    refreshonly => true,
  }

}
