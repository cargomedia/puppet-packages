define janus::plugin::audioroom(
  $recording_enabled = 'yes',
  $recording_pattern = 'rec-#{id}-#{time}-#{type}',
  $job_pattern = 'job-#{md5}',
  $rest_url = 'http://127.0.0.1:8088/janus',
) {

  require 'janus::common_audioroom'


  $instance_base_dir =  "/opt/janus-cluster/${title}"
  $instance_name = "janus_${title}"

  $archive_path = "${instance_base_dir}/var/lib/janus/recordings"
  $jobs_path = "${instance_base_dir}/var/lib/janus/jobs"

  file { "${instance_base_dir}/usr/lib/janus/plugins.enabled/libjanus_audioroom.so":
    ensure    => link,
    target    => '/usr/lib/janus/plugins/libjanus_audioroom.so',
    require   => Janus::Core::Mkdir[$instance_name],
  }

  file { "${instance_base_dir}/etc/janus/janus.plugin.cm.audioroom.cfg":
    ensure    => 'present',
    content   => template("${module_name}/plugin/audioroom.cfg"),
    owner     => '0',
    group     => '0',
    mode      => '0644',
    notify    => Service[$instance_name],
    require   => Janus::Core::Mkdir[$instance_name],
  }

  @bipbip::entry { "janus-audioroom-${title}":
    plugin  => 'janus-audioroom',
    options => {
      'url' => $rest_url,
    }
  }
}
