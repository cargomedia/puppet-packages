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
  $ssl_cert = undef,
  $ssl_key = undef,
) {

  require 'janus::common'
  require 'logrotate'

  $janus_cluster_basedir = '/opt/janus-cluster'

  $instance_name = $origin ? {
    true     => 'janus',
    default  => "janus_${title}",
  }

  $base_dir = $origin ? {
    true    => '',
    default => "${janus_cluster_basedir}/${title}",
  }

  $ssl_config_dir = "${base_dir}/etc/janus/ssl"

  $ssl_cert_content = $ssl_cert ? {
    undef => template("${module_name}/ssl-cert-janus-snakeoil.pem"),
    default => $ssl_cert,
  }
  $ssl_key_content = $ssl_key ? {
    undef => template("${module_name}/ssl-cert-janus-snakeoil.key"),
    default => $ssl_key,
  }

  $plugins_folder = "${base_dir}/usr/lib/janus/plugins.enabled"
  $transports_folder = "${base_dir}/usr/lib/janus/transports.enabled"
  $config_dir = "${base_dir}/etc/janus"

  janus::core::mkdir { $instance_name:
    base_dir          => $base_dir,
    config_dir        => $config_dir,
    plugins_folder    => $plugins_folder,
    transports_folder => $transports_folder,
    ssl_config_dir    => $ssl_config_dir,
  }

  $log_file = "${base_dir}/var/log/janus/janus.log"
  $config_file = "${base_dir}/etc/janus/janus.cfg"

  logrotate::entry{ $instance_name:
    content => template("${module_name}/logrotate"),
  }

  file {
    $config_file:
      ensure   => file,
      content  => template("${module_name}/config"),
      owner    => '0',
      group    => '0',
      mode     => '0644',
      notify   => Service[$instance_name];
    "${ssl_config_dir}/cert.pem":
      ensure   => file,
      content  => $ssl_cert_content,
      owner    => 'janus',
      group    => 'janus',
      mode     => '0644',
      notify   => Service[$instance_name];
    "${ssl_config_dir}/cert.key":
      ensure   => file,
      content  => $ssl_key_content,
      owner    => 'janus',
      group    => 'janus',
      mode     => '0640',
      notify   => Service[$instance_name];
    $log_file:
      ensure => file,
      owner  => 'janus',
      group  => 'janus',
      mode   => '0644';
  }

  daemon { $instance_name:
    binary    => '/usr/bin/janus',
    args      => "-o -C ${config_file} -L ${log_file} -F ${config_dir}",
    user      => 'janus',
    core_dump => $core_dump,
    require   => [File[$config_file, $config_dir, $log_file]],
  }
}
