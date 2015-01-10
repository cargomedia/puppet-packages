class jenkins::slave(
  $clusterId
) {

  require 'jenkins::common'

  ssh::auth::grant {"jenkins@${::clientcert} for jenkins@cluster-${clusterId}":
    id => "jenkins@cluster-${clusterId}",
    user => 'jenkins',
  }

}
