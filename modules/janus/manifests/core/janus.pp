define janus::core::janus (
  $origin = false,
  $bind_address = undef,
  $token_auth = 'no',
  $api_secret = undef,
  $rtp_port_range_min = 20000,
  $rtp_port_range_max = 25000,
  $stun_server = undef,
  $stun_port = 3478,
  $turn_server = undef,
  $turn_port = 3479,
  $turn_type = 'udp',
  $turn_user = 'myuser',
  $turn_pwd = 'mypassword',
  $nat_1_1_mapping = undef,
  $turn_rest_api = undef,
  $turn_rest_api_key = undef,
  $core_dump = true,
) {

  require 'janus::common'
  require 'logrotate'

  $instance_name = $origin ? {
    true     => 'janus',
    default  => "janus_${title}",
  }

  $base_dir = $origin ? {
    true    => '',
    default => "/opt/janus-cluster/${title}",
  }

  exec { "Create ${base_dir} dirs for ${title}":
    command => "mkdir -p ${base_dir}/etc && mkdir -p ${base_dir}/var/lib && mkdir -p ${base_dir}/var/log && mkdir -p ${base_dir}/usr/lib/janus",
    path    => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }

  $plugins_folder = "${base_dir}/usr/lib/janus/plugins"
  $transports_folder = "${base_dir}/usr/lib/janus/transports"

  $config_dir = "${base_dir}/etc/janus"
  $log_file = "${base_dir}/var/log/janus/janus.log"
  $config_file = "${base_dir}/etc/janus/janus.cfg"
  $ssl_config_dir = "${base_dir}/etc/janus/ssl"

  logrotate::entry{ $instance_name:
    content => template("${module_name}/logrotate"),
  }

  file {
    [$config_dir, "${base_dir}/etc/janus/ssl", $plugins_folder, $transports_folder]:
      ensure  => directory,
      owner   => '0',
      group   => '0',
      mode    => '0644',
      require => Exec["Create ${base_dir} dirs for ${title}"];
    ["${base_dir}/var/lib/janus"]:
      ensure => directory,
      owner  => 'janus',
      group  => 'janus',
      mode   => '0644';
    ["${base_dir}/var/lib/janus/recordings", "${base_dir}/var/lib/janus/jobs"]:
      ensure => directory,
      owner  => 'janus',
      group  => 'janus',
      mode   => '0666';
    "${base_dir}/var/log/janus":
      ensure => directory,
      owner  => 'janus',
      group  => 'janus',
      mode   => '0644';
  }
  ->

  file {
    $log_file:
      ensure => file,
      owner  => 'janus',
      group  => 'janus',
      mode   => '0644';
    "${ssl_config_dir}/cert.pem":
      ensure  => file,
      content => template("${module_name}/ssl-cert-janus-snakeoil.pem"),
      owner   => 'janus',
      group   => 'janus',
      mode    => '0644';
    "${ssl_config_dir}/cert.key":
      ensure  => file,
      content => template("${module_name}/ssl-cert-janus-snakeoil.key"),
      owner   => 'janus',
      group   => 'janus',
      mode    => '0640';
    $config_file:
      ensure   => file,
      content  => template("${module_name}/config"),
      owner    => '0',
      group    => '0',
      mode     => '0644',
      notify   => Service[$instance_name],
  }

  daemon { $instance_name:
    binary    => '/usr/bin/janus',
    args      => "-o -C ${config_file} -L ${log_file} -F ${config_dir}",
    user      => 'janus',
    core_dump => $core_dump,
    require   => [File[$config_file, $config_dir, $log_file]],
  }
}
