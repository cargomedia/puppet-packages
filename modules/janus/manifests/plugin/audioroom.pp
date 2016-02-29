define janus::plugin::audioroom(
  $prefix = '/',
  $recording_enabled = 'yes',
  $recording_pattern = 'rec-#{id}-#{time}-#{type}',
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

  file { "${home_path}/etc/janus/janus.plugin.cm.audioroom.cfg":
    ensure    => 'present',
    content   => template("${module_name}/plugin/audioroom.cfg"),
    owner     => '0',
    group     => '0',
    mode      => '0644',
    notify    => Service[$instance_name],
  }

  # symlink to /prefix/usr/lib/plugins/lib_***** from /usr/lib/plugins/lib_***

  @bipbip::entry { "${name}-janus-audioroom":
    plugin  => 'janus-audioroom',
    options => {
      'url' => $rest_url,
    }
  }
}
