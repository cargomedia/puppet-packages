class janus::plugin::audioroom {

  file { '/etc/janus/janus.plugin.audioroom.cfg':
    ensure    => 'present',
    content   => template("${module_name}/plugin/audioroom.cfg"),
    owner     => 'root',
    group     => 'root',
    mode      => '0644',
  }
  ->

  janus::plugin { 'audioroom': }

}
