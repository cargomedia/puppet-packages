node default {

  class {'bipbip':
    api_key => 'foo',
  }

  class {'monit':}
  class {'monit::entry::system':}
}
