node default {

  require 'monit'

  class {'copperegg-revealcloud':
    api_key => 'my_key',
    label => 'foo',
    tags => ['tag1', 'tag2'],
    enable_node => false,
  }
}
