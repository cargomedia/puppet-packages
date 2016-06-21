node default {

  class { 'copperegg_revealcloud':
    api_key     => 'my_key',
    label       => 'foo',
    enable_node => false,
  }
}
