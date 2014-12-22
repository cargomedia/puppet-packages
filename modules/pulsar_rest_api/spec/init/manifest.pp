node default {

  require 'monit'

  class { 'pulsar_rest_api':
    port          => 80,

    mongodbHost   => 'localhost',
    mongodbPort   => 27017,

    pulsarRepo    => undef,
    pulsarBranch  => undef,

    auth          => undef,

    sslKey        => undef,
    sslCert       => undef,
    sslPfx        => undef,
    sslPassphrase => undef
  }
}
