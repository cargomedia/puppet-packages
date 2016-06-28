define janus_cluster::member (
  $cluster_manager_url,
  $webSocketAddress,
  $data = { },
) {


  $register_data = {
    id               => $name,
    webSocketAddress => $webSocketAddress,
    data             => $data,
  }

  file { '/usr/bin/register-janus-cluster-member':
    content => template('janus_cluster/register_member.sh.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '755',
  }
  ~>

  daemon { 'janus-cluster-member':
    binary => '/usr/bin/register-janus-cluster-member',
  }
}
