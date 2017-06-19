node default {

  class { 'mms::agent::backup':
    api_key => 'test-key',
    mms_group_settings => 'test-group',
  }
}
