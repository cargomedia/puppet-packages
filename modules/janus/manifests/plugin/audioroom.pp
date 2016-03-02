class janus::plugin::audioroom(
  $recording_enabled = 'yes',
  $archive_path = '/var/lib/janus/recordings',
  $recording_pattern = 'rec-#{id}-#{time}-#{type}',
  $jobs_path = '/var/lib/janus/jobs',
  $job_pattern = 'job-#{md5}',
  $src_version = undef,
  $src_repo = undef,
  $rest_url = 'http://127.0.0.1:8088/janus',
) {

  include 'janus'
  require 'apt'

  file { '/etc/janus/janus.plugin.cm.audioroom.cfg':
    ensure    => 'present',
    content   => template("${module_name}/plugin/audioroom.cfg"),
    owner     => '0',
    group     => '0',
    mode      => '0644',
    notify    => Service['janus'],
  }

  if $src_version {
    require 'git'
    require 'build::autoconf'
    require 'build::libtool'
    require 'build::dev::libglib2'
    require 'build::dev::libjansson'

    package { ['libopus-dev']:
      provider => 'apt'
    }

    $src_path = '/opt/janus/janus-gateway-audioroom'
    $src_remote = $src_repo ? { undef => 'https://github.com/cargomedia/janus-gateway-audioroom.git',  default => $src_repo }
    git::repository { 'janus-gateway-audioroom':
      remote    => $src_remote,
      directory => $src_path,
      revision  => $src_version,
    }
    ~>

    exec { "Install ${name} from Source":
      provider    => shell,
      command     => template("${module_name}/plugin_install.sh"),
      path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
      refreshonly => true,
      timeout     => 900,
      notify      => Service['janus'],
    }
  } else {
    package { 'janus-gateway-audioroom':
      provider => 'apt',
      notify   => Service['janus'],
    }
  }

  @bipbip::entry { 'janus-audioroom':
    plugin  => 'janus-audioroom',
    options => {
      'url' => $rest_url,
    }
  }
}
