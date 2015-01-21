node default {

  require 'monit'

  class { 'pulsar_rest_api':
    port           => 8080,

    mongodb_host   => 'localhost',
    mongodb_port   => 27017,

    pulsar_repo    => undef,
    pulsar_branch  => undef,

    auth           => undef,

    ssl_key        => undef,
    ssl_cert       => undef,
    ssl_pfx        => undef,
    ssl_passphrase => undef
  }
}
