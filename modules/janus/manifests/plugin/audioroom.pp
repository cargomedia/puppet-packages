class janus::plugin::audioroom(
  $archive_path = '/var/lib/janus/recordings',
  $recording_pattern = 'rec-#{id}-#{time}-#{type}',
  $jobs_path = '/var/lib/janus/jobs',
  $job_pattern = 'job-#{md5}'
) {

  file { '/etc/janus/janus.plugin.cm.audioroom.cfg':
    ensure    => 'present',
    content   => template("${module_name}/plugin/audioroom.cfg"),
    owner     => '0',
    group     => '0',
    mode      => '0644',
  }
  ->

  janus::plugin { 'audioroom': }

}
