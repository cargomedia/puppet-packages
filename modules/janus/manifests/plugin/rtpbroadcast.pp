define janus::plugin::rtpbroadcast(
  $hostname,
  $prefix = undef,
  $minport = 8000,
  $maxport = 9000,
  $mountpoint_info_interval = 10,
  $udp_relay_queue_enabled = false,
  $udp_relay_interval = 50000,
  $keyframe_distance_alert = 600,
  $recording_enabled = true,
  $recording_pattern = 'rec-#{id}-#{time}-#{type}',
  $thumbnailing_pattern = 'thum-#{id}-#{time}-#{type}',
  $thumbnailing_interval = 60,
  $thumbnailing_duration = 10,
  $job_pattern = 'job-#{md5}',
  $rest_url = 'http://127.0.0.1:8088/janus',
  $jobs_path = undef,
) {

  require 'janus::common'
  require 'janus::common_rtpbroadcast'

  Janus::Server::Setup_dirs[$name] -> Janus::Plugin::Rtpbroadcast[$name]

  $instance_name = $prefix? {
    undef => 'janus',
    default => "janus_${name}"
  }

  $instance_base_dir = $prefix? {
    undef => '',
    default =>"${prefix}/${title}"
  }

  $archive_path = "${instance_base_dir}/var/lib/janus/recordings"
  $jobs_path_final = $jobs_path ? { undef => "${instance_base_dir}/var/lib/janus/jobs", default => $jobs_path }
  $log_file = "${instance_base_dir}/var/log/janus/janus.log"

  file { "${instance_base_dir}/usr/lib/janus/plugins.enabled/libjanus_rtpbroadcast.so":
    ensure    => link,
    target    => '/usr/lib/janus/plugins/libjanus_rtpbroadcast.so',
  }
  ->

  file { "${instance_base_dir}/etc/janus/janus.plugin.cm.rtpbroadcast.cfg":
    ensure    => 'present',
    content   => template("${module_name}/plugin/rtpbroadcast.cfg"),
    owner     => '0',
    group     => '0',
    mode      => '0644',
    notify    => Daemon[$instance_name],
  }

  @bipbip::entry { "${name}-rtpbroadcast":
    plugin  => 'janus-rtpbroadcast',
    options => {
      'url' => $rest_url,
    }
  }

  @bipbip::entry { "${name}-logparser-janus-keyframe-overdue":
    plugin  => 'log-parser',
    options => {
      'metric_group' => 'janus-rtpbroadcast',
      'path'         => $log_file,
      'matchers'     => [
        { 'name'   => 'streams_keyframe_overdue',
          'regexp' => 'Key frame overdue on source' },
      ]
    },
  }
}
