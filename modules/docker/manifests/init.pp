class docker {

  include 'apt'
  include 'apt::transport_https'

  apt::source { 'docker':
    entries => [
      "deb https://apt.dockerproject.org/repo debian-${::facts['lsbdistcodename']} main",
    ],
    keys    => {
      'docker' => {
        'key'        => '2C52609D',
        'key_server' => 'hkp://ha.pool.sks-keyservers.net',
      }
    },
    require => Class['apt::transport_https'],
  }

  package { 'docker-engine':
    provider => 'apt',
    require  => Apt::Source['docker'],
  }

}
