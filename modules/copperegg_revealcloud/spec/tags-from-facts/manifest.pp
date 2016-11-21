node default {

  class { 'copperegg_revealcloud':
    api_key     => 'my_key',
    label       => 'foo',
    tags        => ['custom1', 'custom2'],
    enable_node => false,
  }
}
