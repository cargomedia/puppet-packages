class nginx::package {

  require 'apt'
  include 'openssl'

  if ($::facts['lsbdistcodename'] == 'jessie') {

    # Install from Backports which is compiled against OpenSSL 1.0.2

    require 'apt::source::backports'

    apt::preference { [
      'nginx-full',
      'nginx-common',
    ]:
      pin          => 'release a=jessie-backports',
      pin_priority => 1000,
      before       => Package['nginx-full'],
    }
    ->

    package { 'nginx-full':
      ensure   => present,
      provider => 'apt',
      require  => User['nginx'],
    }

    user { 'nginx':
      ensure     => present,
      system     => true,
    }

  } else {

    apt::source { 'nginx':
      entries => [
        "deb http://nginx.org/packages/debian/ ${::facts['lsbdistcodename']} nginx",
        "deb-src http://nginx.org/packages/debian/ ${::facts['lsbdistcodename']} nginx"
      ],
      keys    => {
        'nginx' => {
          key     => '7BD9BF62',
          key_url => 'http://nginx.org/keys/nginx_signing.key',
        }
      }
    }
    ->

    package { 'nginx':
      ensure   => present,
      provider => 'apt',
    }

  }

}
