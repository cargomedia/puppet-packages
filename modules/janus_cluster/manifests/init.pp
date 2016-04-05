class janus_cluster (
  $port = 8080,
  $version = latest
) {
  require 'nodejs'

  user { 'janus-cluster':
    ensure  => present,
    system  => true,
  }

  package { 'janus-cluster':
    ensure   => $version,
    provider => 'npm',
  }

  daemon { 'janus-cluster':
    binary  => '/usr/bin/node',
    args    => "/usr/bin/janus-cluster --port ${port}",
    user    => 'janus-cluster',
  }
}
