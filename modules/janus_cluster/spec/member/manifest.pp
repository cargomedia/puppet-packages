node default {

  janus_cluster::member { 'node-id':
    cluster_manager_url => 'http://cluster-manager',
    webSocketAddress    => 'ws://node-address',
    data                => {
      rtpbroadcast => {
        role                => 'repeater',
        upstream            => 'upstream-id',
      }
    }
  }
}
