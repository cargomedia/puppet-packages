node default {

  class {'copperegg-revealcloud':
#    api_key => 'DqzXHldVSF14giCO',
    api_key => 'my_key',
    label => 'foo',
    tags => ['tag1', 'tag2'],
  }
}
