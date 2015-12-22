class janus::plugin::audioroom(
  $archive_path = '/var/lib/janus/recordings',
  $recording_pattern = 'rec-#{id}-#{time}-#{type}',
  $jobs_path = '/var/lib/janus/jobs',
  $job_pattern = 'job-#{md5}',
  $src_version = undef,
) {

  include 'janus'
  require 'apt'

  file { '/etc/janus/janus.plugin.cm.audioroom.cfg':
    ensure    => 'present',
    content   => template("${module_name}/plugin/audioroom.cfg"),
    owner     => '0',
    group     => '0',
    mode      => '0644',
  }

  if $src_version {
    require 'git'
    require 'build::autoconf'
    require 'build::libtool'
    require 'build::dev::libglib2'
    require 'build::dev::libjansson'

    package {['libopus-dev']:
      provider => 'apt'
    }

    git::repository { "Janus Plugin ${name}":
      remote    => 'https://github.com/cargomedia/janus-gateway-audioroom.git',
      directory => "/opt/janus/build/${name}",
      revision  => $src_version,
    }
    ~>

    exec { "Install ${name} from Source":
      provider    => shell,
      command     => template("${module_name}/plugin_install.sh"),
      path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
      timeout     => 900,
    }
  } else {
    package { "janus-gateway-audioroom":
      provider => 'apt',
    }
  }

}
