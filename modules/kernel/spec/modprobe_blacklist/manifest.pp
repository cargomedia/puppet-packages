node default {

  kernel::modprobe_blacklist {'foo':
    modules => ['foo1', 'foo2'],
  }

  kernel::modprobe_blacklist {'bar':
    modules => ['bar1'],
  }

}
