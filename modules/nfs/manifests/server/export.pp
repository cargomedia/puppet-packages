define nfs::server::export($publicPath = $name, $localPath, $configuration) {

  include 'nfs::server'

  $path = shellquote("/nfsexport${publicPath}")
  $filename = md5($name)

  exec {$path:
    command => "mkdir -p ${path}",
    creates => $path,
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
  ->

  mount::entry {$path:
    source => $localPath,
    options => 'bind',
    mount => true,
  }
  ->

  file {"/etc/exports.d/${filename}":
    ensure => file,
    content => template('nfs/export'),
    owner => '0',
    group => '0',
    mode => '644',
    notify => Exec['/etc/exports'],
  }
}
