class nginx::package {
  anchor {'nginx::package::begin': }
  anchor {'nginx::package::end': }

  case $::operatingsystem {
    centos,fedora,rhel,redhat,scientific: {
      class {'nginx::package::redhat':
        require => Anchor['nginx::package::begin'],
        before  => Anchor['nginx::package::end'],
      }
    }
    debian,ubuntu: {
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
      class {'nginx::package::debian':
        require => Anchor['nginx::package::begin'],
        before  => Anchor['nginx::package::end'],
      }
    }
    opensuse,suse: {
      class {'nginx::package::suse':
        require => Anchor['nginx::package::begin'],
        before  => Anchor['nginx::package::end'],
      }
    }
  }
}
