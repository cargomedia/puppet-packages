class janus::plugin::audioroom(
  $recording_pattern = 'rec-%1$s-%2$llu-%3$s',
) {

  file { '/etc/janus/janus.plugin.audioroom.cfg':
    ensure    => 'present',
    content   => template("${module_name}/plugin/audioroom.cfg"),
    owner     => '0',
    group     => '0',
    mode      => '0644',
  }
  ->

  janus::plugin { 'audioroom': }

}
