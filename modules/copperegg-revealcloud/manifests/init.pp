class copperegg-revealcloud(
  $api_key,
  $label = $fqdn,
  $tags = [],
  $version = 'v3.3-9-g06271da'
) {

  case $architecture {
    i386: { $url = "http://cdn.copperegg.com/revealcloud/${version}/linux-2.6/i386/revealcloud" }
    amd64: { $url = "http://cdn.copperegg.com/revealcloud/${version}/linux-2.6/x86_64/revealcloud" }
    default: { fail('Unrecognized architecture') }
  }

  $dir = '/usr/local/revealcloud'
  $api_host = 'api.copperegg.com'
  $tagsString = join($tags, ',')

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

  service {'revealcloud':
    hasstatus => false,
  }
}
