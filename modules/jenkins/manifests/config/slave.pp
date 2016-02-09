define jenkins::config::slave(
  $host,
  $num_executors = 1,
  $credential_id = 'cluster-credential',
  $cluster_id = undef, # For filtering exported resource
) {

  include 'jenkins::config::main'

  file { "/var/lib/jenkins/nodes/${host}":
    ensure    => 'directory',
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
  }

  file { "/var/lib/jenkins/nodes/${host}/config.xml":
    ensure    => 'present',
    content   => template("${module_name}/config/slave.xml"),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Service['jenkins'],
  }

}
