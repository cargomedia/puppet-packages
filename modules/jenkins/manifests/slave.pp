class jenkins::slave(
  $cluster_id
) {

  require 'jenkins::common'
  require 'java'

  ssh::auth::grant {"jenkins@${::clientcert} for jenkins@cluster-${cluster_id}":
    id => "jenkins@cluster-${cluster_id}",
    user => 'jenkins',
  }

}
