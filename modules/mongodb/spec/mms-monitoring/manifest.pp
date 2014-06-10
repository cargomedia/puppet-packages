node default {

  class {'mongodb::mms::monitoring':
    api_key => 'test-key'
  }
}
