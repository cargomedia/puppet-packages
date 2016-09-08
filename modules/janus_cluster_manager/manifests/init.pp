class janus_cluster_manager (
  $port = 8080,
  $version = latest
) {
  require 'nodejs'

  user { 'janus-cluster-manager':
    ensure  => present,
    system  => true,
  }

  package { 'janus-cluster-manager':
    ensure   => $version,
    provider => 'npm',
  }

  daemon { 'janus-cluster-manager':
    binary  => '/usr/bin/node',
    args    => "/usr/bin/janus-cluster-manager --port ${port}",
    user    => 'janus-cluster-manager',
  }
}
