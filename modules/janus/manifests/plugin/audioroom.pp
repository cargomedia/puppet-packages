class janus::plugin::audioroom {

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
