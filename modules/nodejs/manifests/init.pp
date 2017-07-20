class nodejs {

  require 'apt'

  apt::source { 'nodesource':
    entries => [
      "deb https://deb.nodesource.com/node_6.x ${::facts['lsbdistcodename']} main",
      "deb-src https://deb.nodesource.com/node_6.x ${::facts['lsbdistcodename']} main",
    ],
    keys    => {
      'nodesource' => {
        key     => '68576280',
        key_url => 'https://deb.nodesource.com/gpgkey/nodesource.gpg.key',
      }
    },
    require => Class['apt::transport_https'],
    notify  => Package['nodejs'],
  }

  package { 'nodejs':
    ensure   => 'latest',
    provider => 'apt',
    require  => Apt::Source['nodesource'],
  }

}
