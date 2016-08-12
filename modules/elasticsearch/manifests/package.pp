class elasticsearch::package (
  $repository_version = '1.3',
){

  apt::source { 'elasticsearch':
    entries => [
      "deb http://packages.elastic.co/elasticsearch/${repository_version}/debian stable main",
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
    require      => Package['elasticsearch'],
    subscribe    => [Apt::Source['elasticsearch'], Package['elasticsearch']],
    refreshonly  => true,
  }

}
