define nfs::server::export($publicPath = $name, $localPath, $configuration) {

  include 'nfs::server'

  $filename = md5($name)
  file {"/etc/exports.d/${filename}":
    ensure => file,
    content => template('nfs/export'),
    owner => '0',
    group => '0',
    mode => '644',
    notify => Exec['/etc/exports'],
  }
}
