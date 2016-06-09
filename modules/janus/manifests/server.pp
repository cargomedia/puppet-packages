define janus::server (
  $prefix = undef,
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
  $debug_level = 2,
) {

  require 'janus::common'
  require 'logrotate'

  $instance_name = $prefix? {
    undef => 'janus',
    default => "janus_${title}"
  }

  $instance_base_dir = $prefix? {
    undef => '',
    default =>"${prefix}/${title}"
  }

  $ssl_config_dir = "${instance_base_dir}/etc/janus/ssl"

  $ssl_cert_content = $ssl_cert ? {
    undef => template("${module_name}/ssl-cert-janus-snakeoil.pem"),
    default => $ssl_cert,
  }
  $ssl_key_content = $ssl_key ? {
    undef => template("${module_name}/ssl-cert-janus-snakeoil.key"),
    default => $ssl_key,
  }

  $plugins_folder = "${instance_base_dir}/usr/lib/janus/plugins.enabled"
  $transports_folder = "${instance_base_dir}/usr/lib/janus/transports.enabled"
  $config_dir = "${instance_base_dir}/etc/janus"

  janus::server::setup_dirs { $title:
    base_dir          => $instance_base_dir,
    config_dir        => $config_dir,
    plugins_folder    => $plugins_folder,
    transports_folder => $transports_folder,
    ssl_config_dir    => $ssl_config_dir,
  }

  $log_file = "${instance_base_dir}/var/log/janus/janus.log"
  $config_file = "${instance_base_dir}/etc/janus/janus.cfg"

  logrotate::entry { $instance_name:
    path    => $log_file,
  }

  @fluentd::config::source_tail{ $instance_name:
    path        => $log_file,
    fluentd_tag => 'janus',
    format      => '/(\[(?<time>[^\]]+)\] )?(?<message>.*)/',
  }

  file {
    $config_file:
      ensure    => file,
      content   => template("${module_name}/config"),
      owner     => '0',
      group     => '0',
      mode      => '0644',
      notify    => Daemon[$instance_name];
    "${ssl_config_dir}/cert.pem":
      ensure    => file,
      content   => $ssl_cert_content,
      owner     => 'janus',
      group     => 'janus',
      mode      => '0644',
      notify    => Daemon[$instance_name];
    "${ssl_config_dir}/cert.key":
      ensure    => file,
      content   => $ssl_key_content,
      owner     => 'janus',
      group     => 'janus',
      mode      => '0640',
      notify    => Daemon[$instance_name];
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
    require   => [
      File[$config_file, $log_file, "${ssl_config_dir}/cert.key", "${ssl_config_dir}/cert.pem"],
      Janus::Server::Setup_dirs[$title],
    ],
  }

  if $instance_name != 'janus' {
    if ! defined(Service['janus']) {
      service { 'janus':
        ensure => stopped,
        enable => false,
      }
    }
  }
}
