define janus::core::janus (
  $prefix = '/',
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

  $instance_name = "janus_${name}"

  if ($prefix != '/') {
    exec { "${prefix} for ${name}":
      command => "mkdir -p ${prefix}/etc && mkdir -p ${prefix}/var/lib && mkdir -p ${prefix}/var/log && mkdir -p ${prefix}/usr/lib/janus",
      path    => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    }
    $home_path = $prefix
  } else {
    $home_path = ''
  }

  $plugins_folder = "${home_path}/usr/lib/janus/plugins"
  $transports_folder = "${home_path}/usr/lib/janus/transports"

  $config_dir = "${home_path}/etc/janus"
  $log_file = "${home_path}/var/log/janus/janus.log"
  $config_file = "${home_path}/etc/janus/janus.cfg"
  $ssl_config_dir = "${home_path}/etc/janus/ssl"

  logrotate::entry{ $instance_name:
    content => template("${module_name}/logrotate"),
  }

  file {
    [$config_dir, "${home_path}/etc/janus/ssl"]:
      ensure => directory,
      owner  => '0',
      group  => '0',
      mode   => '0644',
      require => Exec["${home_path} for ${name}"];
    ["${home_path}/var/lib/janus"]:
      ensure => directory,
      owner  => 'janus',
      group  => 'janus',
      mode   => '0644';
    ["${home_path}/var/lib/janus/recordings", "${home_path}/var/lib/janus/jobs"]:
      ensure => directory,
      owner  => 'janus',
      group  => 'janus',
      mode   => '0666';
    "${home_path}/var/log/janus":
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
  ->

  daemon { $instance_name:
    binary    => "/usr/bin/janus",
    args      => "-o -C ${config_file} -L ${log_file}",
    user      => 'janus',
    core_dump => $core_dump,
    require   => [File[$config_file, $config_dir, $log_file]],
  }
}
