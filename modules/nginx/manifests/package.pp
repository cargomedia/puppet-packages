class nginx::package {

  apt::source {'nginx':
    entries => [
      'deb http://nginx.org/packages/debian/ squeeze nginx',
      'deb-src http://nginx.org/packages/debian/ squeeze nginx'
    ],
    keys => {
      'nginx' => {
        key     => '7BD9BF62',
        key_url => 'http://nginx.org/keys/nginx_signing.key',
      }
    }
  }
  ->

  package {'nginx':
    ensure => present,
  }
}
