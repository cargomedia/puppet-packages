node default {

  require 'monit'

  class {'mms::agent::backup':
    api_key => 'test-key'
  }
}
