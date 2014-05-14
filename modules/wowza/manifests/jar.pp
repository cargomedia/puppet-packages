define wowza::jar (
  $get_command,
  $version
) {

  include 'wowza::service'

  $path = "/usr/local/WowzaStreamingEngine/lib/lib-versions/${name}-${version}.jar"
  $symlink = "/usr/local/WowzaStreamingEngine/lib/${name}.jar"

  exec {"install jar: ${name}":
    command => "${get_command} > ${path}",
    unless => "test -h ${symlink} && test $(readlink ${symlink}) = ${path}",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    notify => Service['wowza'],
  }
  ->

  file {$symlink:
    ensure => $path,
  }

}
