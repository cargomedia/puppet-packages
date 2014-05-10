define wowza::jar (
  $get_command,
  $version
) {

  $path = "/usr/local/WowzaStreamingEngine/lib/lib-versions/${name}-${version}.jar"
  $symlink = "/usr/local/WowzaStreamingEngine/lib/${name}.jar"

  exec {"install jar: ${name}":
    command => "${get_command} > ${path}",
    unless => "test -h ${symlink} && test $(readlink ${symlink}) = ${path}",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
  ~>

  file {$symlink:
    ensure => $path,
  }

}
