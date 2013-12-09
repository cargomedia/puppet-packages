class copperegg-revealcloud(
  $api_key,
  $label = $fqdn,
  $tags = [],
  $version = 'v3.3-9-g06271da',
  $enable_node = true
) {

  $dir = '/usr/local/revealcloud'
  $api_host = 'api.copperegg.com'

  case $architecture {
    i386: { $url = "http://cdn.copperegg.com/revealcloud/${version}/linux-2.6/i386/revealcloud" }
    amd64: { $url = "http://cdn.copperegg.com/revealcloud/${version}/linux-2.6/x86_64/revealcloud" }
    default: { fail('Unrecognized architecture') }
  }

  user {'revealcloud':
    ensure => present,
    system => true,
  }
  ->

  file {$dir:
    ensure => directory,
    owner => 'revealcloud',
    group => 'revealcloud',
    mode => '0644',
  }
  ->

  file {"${dir}/run":
    ensure => directory,
    owner => 'revealcloud',
    group => 'revealcloud',
    mode => '0644',
  }
  ->

  file {"${dir}/log":
    ensure => directory,
    owner => 'revealcloud',
    group => 'revealcloud',
    mode => '0644',
  }
  ->

  exec {'download revealcloud':
    command => "curl -sL '${url}' > ${dir}/revealcloud && chmod 0755 ${dir}/revealcloud",
    unless => "test -x ${dir}/revealcloud && ${dir}/revealcloud -V 2>&1 | grep 'Version: ${version}$'",
    user => 'revealcloud',
    group => 'revealcloud',
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    notify => Service['revealcloud'],
  }
  ->

  file {'/etc/init.d/revealcloud':
    content => template('copperegg-revealcloud/init.sh'),
    owner => '0',
    group => '0',
    mode => '0755',
    notify => Service['revealcloud'],
  }
  ~>

  exec {'update-rc.d revealcloud defaults':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

  if $enable_node {
    exec {'enable revealcloud node':
      command => "/etc/init.d/revealcloud stop && ${dir}/revealcloud -x -a ${api_host} -k ${api_key} -E && /etc/init.d/revealcloud start",
      refreshonly => true,
      user => 'revealcloud',
      group => 'revealcloud',
      require => File['/etc/init.d/revealcloud'],
      before => Service['revealcloud'],
    }

    Exec['update-rc.d revealcloud defaults'] ~> Exec['enable revealcloud node']
  }

  service {'revealcloud':
  }
}
