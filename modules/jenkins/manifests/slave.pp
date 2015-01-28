class jenkins::slave(
  $cluster_id,
  $num_executors = 1
) {

  require 'jenkins::common'
  require 'java'

  ssh::auth::grant { "jenkins@${::clientcert} for jenkins@cluster-${cluster_id}":
    id   => "jenkins@cluster-${cluster_id}",
    user => 'jenkins',
  }

  @@jenkins::config::slave { "slave-${::clientcert}":
    cluster_id    => $cluster_id,
    host          => $::fqdn,
    num_executors => $num_executors,
  }

}
