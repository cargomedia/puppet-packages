class cm_janus (
  $http_server_port = 8200,
  $http_server_api_key,
  $websockets_listen_port = 8210,
  $janus_websocket_address = 'ws://127.0.0.1:8300/janus',
  $janus_http_address = 'ws://127.0.0.1:8300/janus',
  $cm_api_base_url,
  $cm_api_key,
  $cm_application_path,
  $jobs_path,
) {

  require 'nodejs'
  require 'build::gpp'
  require 'mjr_convert'

  file { '/etc/cm-janus':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  file { '/etc/cm-janus/config.yaml':
    ensure  => file,
    content => template("${module_name}/config.yaml"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
    before  => Daemon['cm-janus'],
    notify  => Service['cm-janus'],
  }

  user { 'cm-janus':
    ensure => present,
    system => true,
    before  => Daemon['cm-janus'],
  }

  file { ['/var/log/cm-janus', '/var/lib/cm-janus', '/var/lib/cm-janus/jobs-temp-files']:
    ensure  => directory,
    owner   => 'cm-janus',
    group   => 'cm-janus',
    mode    => '0755',
    require => User['cm-janus'],
    before  => Daemon['cm-janus'],
  }

  logrotate::entry{ $module_name:
    content => template("${module_name}/logrotate")
  }

  @bipbip::entry { 'logparser-cm-janus':
    plugin  => 'log-parser',
    options => {
      'metric_group' => 'cm-janus',
      'path' => '/var/log/cm-janus/cm-janus.log',
      'matchers' => [
        { 'name' => 'error',
          'regexp' => 'app error' }
      ]
    }
  }

  package { 'cm-janus':
    ensure   => latest,
    provider => 'npm',
    before  => Daemon['cm-janus'],
    notify   => Service['cm-janus'],
  }

  daemon { 'cm-janus':
    binary  => '/usr/bin/node',
    args    => '/usr/bin/cm-janus -c /etc/cm-janus/config.yaml',
    user    => 'cm-janus',
  }
}
