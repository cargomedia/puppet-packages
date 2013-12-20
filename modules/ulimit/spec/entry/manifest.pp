node default {

  ulimit::entry {'mysql':
    limits => [
      {
        'domain' => 'mysql',
        'type' => '-',
        'item' => 'nofile',
        'value' => 16384
      }
    ]
  }
}
