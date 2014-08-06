node default {

  class {'bipbip':
    api_key => 'mykey',
  }

  class {'bipbip::plugin::cm':
  }

}
