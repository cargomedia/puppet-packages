class openssl {

  require 'apt'

  if ($::facts['lsbdistcodename'] == 'jessie') {

    # Jessie has OpenSSL 1.0.1, we want 1.0.2 from backports

    require 'apt::source::backports'

    apt::preference { [
      'openssl',
      'libssl1.0.0',
      'libssl-dev',
    ]:
      pin          => 'release a=jessie-backports',
      pin_priority => 1000,
      before       => [
        Package['openssl'],
        Package['libssl-dev'],
      ]
    }

  }

  package { ['openssl', 'libssl-dev']:
    ensure   => present,
    provider => 'apt',
  }

}
