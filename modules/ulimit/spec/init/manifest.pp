node default {

  class {'ulimit':
    limits => [
      {
        'domain' => 'root',
        'type' => '-',
        'item' => 'nofile',
        'value' => 65536,
      }
    ]
  }
}
