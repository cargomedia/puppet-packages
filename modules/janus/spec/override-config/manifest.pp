node default {

  $ssl_paths="\n[certificates]\ncert_pem = /etc/janus/ssl/cert.pem\ncert_key = /etc/janus/ssl/cert.key\n"

  file {
    '/tmp':
      ensure    => directory,
      owner     => '0',
      group     => '0',
      mode      => '0755';
    '/tmp/janus.transport.http.cfg':
      ensure    => file,
      content   => "[general]\nhttp=true\nport = 55555\n",
      owner     => '0',
      group     => '0',
      mode      => '0644';
    '/tmp/janus.transport.websockets.cfg':
      ensure    => file,
      content   => "[general]\nws=true\nws_port = 55556\n",
      owner     => '0',
      group     => '0',
      mode      => '0644';
    '/tmp/janus.plugin.cm.rtpbroadcast.cfg':
      ensure    => file,
      content   => "[general]\nminport=1024\nmaxport=1099\n",
      owner     => '0',
      group     => '0',
      mode      => '0644';
    '/tmp/januxx.foo.conf':
      ensure    => file,
      content   => "[general]\ninterface = 127.0.0.1\ndebug_level=9\nice_lite=false\nice_tcp=false\n${ssl_paths}",
      owner     => '0',
      group     => '0',
      mode      => '0644';
  }

  require 'janus::transport::http'
  require 'janus::transport::websockets'
  require 'janus::plugin::rtpbroadcast'

  class { 'janus':
  config_file       => '/tmp/januxx.foo.conf',
  plugin_config_dir => '/tmp',
  }
}
