node default {

  require 'monit'

  class { 'pulsar_rest_api':
    mongodb_host   => 'localhost',
    mongodb_port   => 27017,

    pulsar_repo    => undef,
    pulsar_branch  => undef,

    auth           => undef,
  }
}
