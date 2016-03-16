define janus::plugin::audioroom(
  $prefix = undef,
  $recording_enabled = true,
  $recording_pattern = 'rec-#{id}-#{time}-#{type}',
  $job_pattern = 'job-#{md5}',
  $rest_url = 'http://127.0.0.1:8088/janus',
  $jobs_path = undef,
) {

  require 'janus::common'
  require 'janus::common_audioroom'

  Janus::Server::Setup_dirs[$name] -> Janus::Plugin::Audioroom[$name]

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

  file { "${instance_base_dir}/usr/lib/janus/plugins.enabled/libjanus_audioroom.so":
    ensure    => link,
    target    => '/usr/lib/janus/plugins/libjanus_audioroom.so',
  }
  ->

  file { "${instance_base_dir}/etc/janus/janus.plugin.cm.audioroom.cfg":
    ensure    => 'present',
    content   => template("${module_name}/plugin/audioroom.cfg"),
    owner     => '0',
    group     => '0',
    mode      => '0644',
    before    => Daemon[$instance_name],
    notify    => Service[$instance_name],
  }

  @bipbip::entry { "janus-audioroom-${title}":
    plugin  => 'janus-audioroom',
    options => {
      'url' => $rest_url,
    }
  }
}
