define jenkins::config::slave(
  $host,
  $num_executors = 1,
  $credential_id = 'cluster-credential',
  $cluster_id = undef, # For filtering exported resource
) {

  include 'jenkins::config::main'

  file {"/var/lib/jenkins/config.d/20-slaves-10-${host}.xml":
    ensure    => 'present',
    content   => template("${module_name}/config/main/20-slaves-10-entry.xml"),
    owner     => 'jenkins',
    group     => 'nogroup',
    mode      => '0644',
    notify    => Exec['/var/lib/jenkins/config.xml'],
  }

}
