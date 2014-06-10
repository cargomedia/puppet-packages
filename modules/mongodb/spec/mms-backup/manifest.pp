node default {

  class {'mongodb::mms::backup':
    api_key => 'test-key'
  }
}
