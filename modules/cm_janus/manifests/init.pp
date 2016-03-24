define cm_janus (
  $prefix = undef,
  $http_server_port = 8200,
  $http_server_api_key,
  $websockets_listen_port = 8210,
  $janus_websocket_address = 'ws://127.0.0.1:8300/janus',
  $janus_http_address = 'ws://127.0.0.1:8300/janus',
  $cm_api_base_url,
  $cm_api_key,
  $cm_application_path,
  $jobs_path,
  $job_prefix = 'ionice -c 2 -n 7 nice -n 19',
  $thumbnailWidth = 1920,
  $thumbnailHeight = 540,
) {

  require 'cm_janus::common'

  $instance_name = $prefix? {
    undef => 'cm-janus',
    default => "cm-janus_${title}"
  }

  $instance_base_dir = $prefix? {
    undef => '',
    default =>"${prefix}/${title}"
  }

  cm_janus::setup_dirs { $title:
    base_dir => $instance_base_dir,
  }

  $config_file = "${instance_base_dir}/etc/cm-janus/config.yaml"
  $log_file = "${instance_base_dir}/var/log/cm-janus/cm-janus.log"
  $job_temp_dir = "${instance_base_dir}/var/lib/cm-janus/jobs-temp-files"

  file { $config_file:
    ensure  => file,
    content => template("${module_name}/config.yaml"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
    before  => Daemon[$instance_name],
    notify  => Service[$instance_name],
  }

  logrotate::entry{ $instance_name:
    content => template("${module_name}/logrotate")
  }

  @bipbip::entry { "logparser-${instance_name}":
    plugin  => 'log-parser',
    options => {
      'metric_group' => 'cm-janus',
      'path'         => $log_file,
      'matchers'     => [
        { 'name'   => 'error',
          'regexp' => '^[\d\-\:\s\.]+ERROR' }
      ]
    }
  }

  @fluentd::config::source_tail{ $instance_name:
    path        => $log_file,
    fluentd_tag => 'cm-janus',
    format      => 'json',
    time_key    => 'time',
    time_format => '%FT%T.%L%:z',
  }

  daemon { $instance_name:
    binary    => '/usr/bin/node',
    args      => "/usr/bin/cm-janus -c ${config_file}",
    user      => 'cm-janus',
    subscribe => Package['cm-janus']
  }
}
