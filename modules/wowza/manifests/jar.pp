define wowza::jar (
  $get_command,
  $version
) {

  $source = "/usr/local/WowzaStreamingEngine/lib/lib-versions/${name}-${version}.jar"
  $destination = "/usr/local/WowzaStreamingEngine/lib/${name}.jar"

  exec {"install jar: ${name}":
    command => "${get_command} > ${source}",
    unless => "test -h ${destination} && test $(readlink ${destination}) = ${source}",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
  ~>

  file {$destination:
    ensure => $source,
  }

}
