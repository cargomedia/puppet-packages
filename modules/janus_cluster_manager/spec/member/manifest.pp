node default {

  janus_cluster_manager::member { 'node-id':
    cluster_manager_url   => 'http://cluster-manager',
    web_socket_address    => 'ws://node-address',
    data                  => {
      rtpbroadcast => {
        role                => 'repeater',
        upstream            => 'upstream-id',
      }
    }
  }
}
