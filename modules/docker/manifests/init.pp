class docker {

  include 'apt'
  include 'apt::transport_https'

  apt::source { 'docker':
    entries => [
      "deb https://apt.dockerproject.org/repo debian-${::lsbdistcodename} main",
    ],
    keys    => {
      'docker' => {
        'key'        => '2C52609D',
        'key_server' => 'hkp://p80.pool.sks-keyservers.net:80',
      }
    },
    require => Class['apt::transport_https'],
  }

  package { 'docker-engine':
    provider => 'apt',
    require  => Apt::Source['docker'],
  }

}
