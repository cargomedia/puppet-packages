define janus_cluster_manager::member (
  $cluster_manager_url,
  $web_socket_address,
  $data = { },
) {

  $register_data = {
    id               => $name,
    webSocketAddress => $web_socket_address,
    data             => $data,
  }

  file { "/usr/bin/register-janus-cluster-member-${name}":
    content => template("${module_name}/register_member.sh.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }
  ~>

  daemon { "janus-cluster-member-${name}":
    binary => "/usr/bin/register-janus-cluster-member-${name}",
  }
}
