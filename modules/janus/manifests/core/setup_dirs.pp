define janus::core::setup_dirs (
  $base_dir,
  $config_dir = undef,
  $plugins_folder = undef,
  $transports_folder = undef,
  $ssl_config_dir = undef,
) {

  $config_dir_default = $config_dir ? { undef => "${base_dir}/etc/janus", default => $config_dir }
  $ssl_config_dir_default = $ssl_config_dir_default ? { undef => "${base_dir}/etc/janus/ssl", default => $ssl_config_dir_default }
  $plugins_folder_default = $plugins_folder_default ? { undef => "${base_dir}/usr/lib/janus/plugins.enabled", default => $plugins_folder_default }
  $transports_folder_default = $transports_folder_default ? { undef => "${base_dir}/usr/lib/janus/transports.enabled", default => $transports_folder_default }

  $base_dirs = "${base_dir}/etc ${base_dir}/var/lib ${base_dir}/var/log ${base_dir}/usr/lib/janus"

  exec { "Create base dirs in janus-cluster for ${title}":
    provider    => shell,
    command     => "for i in ${base_dirs}; do mkdir -p \$i; done",
    unless      => "for i in ${base_dirs}; do if ! [ -d \$i ]; then exit 1; fi; done",
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
  ->

  file {
    [ $config_dir_default, $ssl_config_dir_default]:
      ensure  => directory,
      owner   => '0',
      group   => '0',
      mode    => '0644',
      purge   => true,
      recurse => true,
      require => Exec["Create base dirs in janus-cluster for ${title}"];
    [ $plugins_folder_default, $transports_folder_default ]:
      ensure  => directory,
      owner   => 'janus',
      group   => 'janus',
      mode    => '0644',
      require => Exec["Create base dirs in janus-cluster for ${title}"];
    [ "${base_dir}/var/lib/janus", "${base_dir}/var/lib/janus/recordings", "${base_dir}/var/lib/janus/jobs" ]:
      ensure  => directory,
      owner   => 'janus',
      group   => 'janus',
      mode    => '0666',
      require => Exec["Create base dirs in janus-cluster for ${title}"];
    "${base_dir}/var/log/janus":
      ensure  => directory,
      owner   => 'janus',
      group   => 'janus',
      mode    => '0644',
      require => Exec["Create base dirs in janus-cluster for ${title}"];
  }
}
