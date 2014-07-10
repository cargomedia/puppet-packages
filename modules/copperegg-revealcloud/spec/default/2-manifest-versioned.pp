node default {

  class {'copperegg-revealcloud':
    api_key => 'my_key',
    label => 'foo',
    tags => ['tag1', 'tag2'],
    enable_node => false,
    version => 'v3.3-9-g06271da',
  }
}
