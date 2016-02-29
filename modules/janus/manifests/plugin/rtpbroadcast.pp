define janus::plugin::rtpbroadcast(
  $prefix = '/',
  $minport = 8000,
  $maxport = 9000,
  $source_avg_time = 10,
  $remb_avg_time = 3,
  $switching_delay = 1,
  $session_info_update_time = 10,
  $keyframe_distance_alert = 600,
  $recording_enabled = 'yes',
  $recording_pattern = 'rec-#{id}-#{time}-#{type}',
  $thumbnailing_pattern = 'thum-#{id}-#{time}-#{type}',
  $thumbnailing_interval = 60,
  $thumbnailing_duration = 10,
  $job_pattern = 'job-#{md5}',
  $src_version = undef,
  $rest_url = 'http://127.0.0.1:8088/janus',
) {

  if ($prefix != '/') {
    $home_path = $prefix
    $instance_name = "janus_${name}"
  } else {
    $home_path = ''
    $instance_name = 'janus'
  }

  $archive_path = "${home_path}/var/lib/janus/recordings"
  $jobs_path = "${home_path}/var/lib/janus/jobs"
  $log_file = "${home_path}/var/log/janus/janus.log"

  file { "${home_path}/etc/janus/janus.plugin.cm.rtpbroadcast.cfg":
    ensure    => 'present',
    content   => template("${module_name}/plugin/rtpbroadcast.cfg"),
    owner     => '0',
    group     => '0',
    mode      => '0644',
    notify    => Service[$instance_name],
  }

  # symlink to /prefix/usr/lib/plugins/lib_***** from /usr/lib/plugins/lib_***

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
      'path' => $log_file,
      'matchers' => [
        { 'name' => 'streams_keyframe_overdue',
          'regexp' => 'Key frame overdue on source' },
      ]
    },
  }
}
