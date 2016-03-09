define cm_janus::setup_dirs (
  $base_dir,
) {

  $base_dirs = "${base_dir}/etc ${base_dir}/var/lib ${base_dir}/var/log"

  exec { "Create base dirs in cm-janus-cluster for ${title}":
    provider    => shell,
    command     => "for i in ${base_dirs}; do mkdir -p \$i; done",
    unless      => "for i in ${base_dirs}; do if ! [ -d \$i ]; then exit 1; fi; done",
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
  ->

  file {
    [ "${base_dir}/etc/cm-janus"]:
      ensure  => directory,
      owner   => '0',
      group   => '0',
      mode    => '0644',
      purge   => true,
      recurse => true,
      require => Exec["Create base dirs in cm-janus-cluster for ${title}"];
    [ "${base_dir}/var/lib/cm-janus", "${base_dir}/var/lib/cm-janus/jobs-temp-files" ]:
      ensure  => directory,
      owner   => 'cm-janus',
      group   => 'cm-janus',
      mode    => '0666',
      require => Exec["Create base dirs in cm-janus-cluster for ${title}"];
    "${base_dir}/var/log/cm-janus":
      ensure  => directory,
      owner   => 'cm-janus',
      group   => 'cm-janus',
      mode    => '0644',
      require => Exec["Create base dirs in cm-janus-cluster for ${title}"];
  }
}
