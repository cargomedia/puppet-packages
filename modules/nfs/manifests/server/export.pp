define nfs::server::export(
  $client,
  $options
){

  include 'nfs::server'

  exec {"add export $name":
    command     => "/bin/echo \"/nfsexport/$name  $client($options)\" >> /etc/exports",
    require     => Package['nfs-kernel-server'],
    notify      => Exec['reload_nfs_srv']
  }
}
