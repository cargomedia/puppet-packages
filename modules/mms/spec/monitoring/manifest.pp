node default {

  class { 'mms::agent::monitoring':
    api_key       => 'test-key',
    auth_username => 'mms',
    auth_password => 'mms',
  }
}
