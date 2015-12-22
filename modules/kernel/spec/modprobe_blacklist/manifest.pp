node default {

  exec { '/sbin/modprobe blowfish_common': }
  ->
  kernel::modprobe_blacklist { 'blowfish_common':
    modules => ['blowfish_common'],
  }

  kernel::modprobe_blacklist { 'foo':
    modules => ['foo1', 'foo2'],
  }

}
