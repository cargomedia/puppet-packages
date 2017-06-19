node default {

  class { 'mms::agent::monitoring':
    api_key       => 'test-key',
    mms_group_settings => 'test-group',
    auth_username => 'mms',
    auth_password => 'mms',
  }
}
