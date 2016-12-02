class nginx::package {

  require 'apt'

  if ($::facts['lsbdistcodename'] == 'jessie') {

    # Jessie has OpenSSL 1.0.1, but we need 1.0.2 for Chrome
    # Workaround is to install nginx from backports which is built against OpenSSL 1.0.2

    require 'apt::source::backports'

    apt::preference { [
      'nginx-full',
      'nginx-common',
      'libssl1.0.0',
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
