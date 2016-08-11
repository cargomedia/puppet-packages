class elasticsearch::package (
  $repository_version = '1.3',
  $release_version = '1.3.1',
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
    ensure   => $release_version,
    provider => apt,
  }

}
