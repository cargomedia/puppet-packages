node default {

  class { 'mms::agent::backup':
    api_key => 'test-key'
  }
}
