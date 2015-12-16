node default {

  $ssl_paths="\n[certificates]\ncert_pem = /etc/janus/ssl/cert.pem\ncert_key = /etc/janus/ssl/cert.key\n"


  file { '/tmp/janus.transport.http.cfg':
    ensure    => 'present',
    content   => "[general]\nhttp=true\nport = 55555\n",
    owner     => '0',
    group     => '0',
    mode      => '0644',
  }

  file { '/tmp/janus.transport.websockets.cfg':
    ensure    => 'present',
    content   => "[general]\nws=true\nws_port = 55556\n",
    owner     => '0',
    group     => '0',
    mode      => '0644',
  }

  file { '/tmp/janus.plugin.cm.rtpbroadcast.cfg':
    ensure    => 'present',
    content   => "[general]\nminport=1024\nmaxport=1099\n",
    owner     => '0',
    group     => '0',
    mode      => '0644',
  }

  file { '/tmp/januxx.foo.conf':
    ensure    => 'present',
    content   => "[general]\ninterface = 127.0.0.1\ndebug_level=9\nice_lite=false\nice_tcp=false\n${ssl_paths}",
    owner     => '0',
    group     => '0',
    mode      => '0644',
  }

class { 'janus::service':
    config_file => '/tmp/januxx.foo.conf',
    plugin_config_dir => '/tmp',
  }

  require 'janus::transport::http'
  require 'janus::transport::websockets'
  require 'janus::plugin::rtpbroadcast'

}
