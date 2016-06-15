class jenkins::slave(
  $cluster_id,
  $num_executors = 1
) {

  require 'jenkins::common'

  ssh::auth::grant { "jenkins@${::facts['clientcert']} for jenkins@cluster-${cluster_id}":
    id   => "jenkins@cluster-${cluster_id}",
    user => 'jenkins',
  }

  @@jenkins::config::slave { "slave-${::facts['clientcert']}":
    cluster_id    => $cluster_id,
    host          => $::facts['fqdn'],
    num_executors => $num_executors,
  }

}
