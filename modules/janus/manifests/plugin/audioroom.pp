define janus::plugin::audioroom(
  $origin = false,
  $recording_enabled = 'yes',
  $recording_pattern = 'rec-#{id}-#{time}-#{type}',
  $job_pattern = 'job-#{md5}',
  $src_version = undef,
  $rest_url = 'http://127.0.0.1:8088/janus',
) {

  require '::janus::common_audioroom'
  $instance_name = $origin ? {
    true     => 'janus',
    default  => "janus_${title}",
  }

  $base_dir = $origin ? {
    true    => '',
    default => "/opt/janus-cluster/${title}",
  }

  $archive_path = "${base_dir}/var/lib/janus/recordings"
  $jobs_path = "${base_dir}/var/lib/janus/jobs"

  file { "${base_dir}/etc/janus/janus.plugin.cm.audioroom.cfg":
    ensure    => 'present',
    content   => template("${module_name}/plugin/audioroom.cfg"),
    owner     => '0',
    group     => '0',
    mode      => '0644',
    notify    => Service[$instance_name],
  }

  file { "${base_dir}/usr/lib/janus/plugins/libjanus_audioroom.so":
    ensure => link,
    target => '/usr/lib/janus/plugins/libjanus_audioroom.so',
  }

  @bipbip::entry { "janus-audioroom-${title}":
    plugin  => 'janus-audioroom',
    options => {
      'url' => $rest_url,
    }
  }
}
