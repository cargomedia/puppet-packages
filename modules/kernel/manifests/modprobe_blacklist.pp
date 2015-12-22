define kernel::modprobe_blacklist(
  $modules
) {

  kernel::modprobe{ "blacklist-${title}":
    content => template("${module_name}/modprobe_blacklist.erb")
  }
}
