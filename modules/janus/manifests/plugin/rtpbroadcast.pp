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

  require 'janus::common_rtpbroadcast'

  $janus_cluster_basedir = '/opt/janus-cluster'

  $instance_name = $janus::plugin::rtpbroadcast::origin ? {
    true     => 'janus',
    default  => "janus_${title}",
  }

  $base_dir = $janus::plugin::rtpbroadcast::origin ? {
    true    => '',
    default => "${janus_cluster_basedir}/${title}",
  }

  $archive_path = "${base_dir}/var/lib/janus/recordings"
  $jobs_path = "${base_dir}/var/lib/janus/jobs"
  $log_file = "${base_dir}/var/log/janus/janus.log"

  file { "${base_dir}/usr/lib/janus/plugins.enabled/libjanus_rtpbroadcast.so":
    ensure    => link,
    target    => '/usr/lib/janus/plugins/libjanus_rtpbroadcast.so',
    require   => Janus::Core::Mkdir[$instance_name],
  }
  ->

  file { "${base_dir}/etc/janus/janus.plugin.cm.rtpbroadcast.cfg":
    ensure    => 'present',
    content   => template("${module_name}/plugin/rtpbroadcast.cfg"),
    owner     => '0',
    group     => '0',
    mode      => '0644',
    notify    => Service[$instance_name],
    require   => Janus::Core::Mkdir[$instance_name],
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
