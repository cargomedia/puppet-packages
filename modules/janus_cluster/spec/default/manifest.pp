node default {

  class { 'janus_cluster_manager': }
  class { 'janus_cluster::node': }
}
