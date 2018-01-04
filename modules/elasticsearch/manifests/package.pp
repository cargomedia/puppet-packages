class elasticsearch::package (
  $repository_version = '5.x',
){

  apt::source { 'elasticsearch':
    entries => [
      "deb https://artifacts.elastic.co/packages/${repository_version}/apt stable main",
    ],
    keys    => {
      elasticsearch => {
        key     => 'D88E42B4',
        key_url => 'https://packages.elastic.co/GPG-KEY-elasticsearch',
      }
    }
  }

  package { 'elasticsearch':
    ensure   => present,
    provider => apt,
  }

  exec { 'true && /etc/init.d/elasticsearch stop':
    path         => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider     => shell,
    subscribe    => Package['elasticsearch'],
    refreshonly  => true,
  }

}
