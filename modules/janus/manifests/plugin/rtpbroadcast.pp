class janus::plugin::rtpbroadcast(
  $minport = 8000,
  $maxport = 9000,
  $archive_path = '/tmp/recordings',
  $recording_pattern = 'rec-%1$s-%2$llu-%3$s',
  $thumbnailing_pattern = 'thum-%1$s-%2$llu-%3$s',
  $thumbnailing_interval = 60,
  $thumbnailing_duration = 10
) {

  file { '/etc/janus/janus.plugin.rtpbroadcast.cfg':
    ensure    => 'present',
    content   => template("${module_name}/plugin/rtpbroadcast.cfg"),
    owner     => '0',
    group     => '0',
    mode      => '0644',
  }
  ->

  janus::plugin { 'rtpbroadcast': }

}
