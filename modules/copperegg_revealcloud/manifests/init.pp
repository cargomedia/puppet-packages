class copperegg_revealcloud(
  $api_key,
  $label = $::clientcert,
  $tags = $::copperegg_tags,
  $version = 'v3.3-92-g0814c8d',
  $enable_node = true
) {

  $dir = '/usr/local/revealcloud'
  $api_host = 'api.copperegg.com'
  $tag_list = $tags ? { undef => [], default => $tags }

  case $::architecture {
    i386: { $url = "http://cdn.copperegg.com/revealcloud/${version}/linux-2.6/i386/revealcloud" }
    amd64: { $url = "http://cdn.copperegg.com/revealcloud/${version}/linux-2.6/x86_64/revealcloud" }
    default: { fail('Unrecognized architecture') }
  }

  file { $dir:
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }
  ->

  file { "${dir}/run":
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }
  ->

  file { "${dir}/log":
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }
  ->

  helper::script { 'download revealcloud':
    content => template("${module_name}/download.sh"),
    unless  => "test -x ${dir}/revealcloud && ${dir}/revealcloud -V 2>&1 | grep 'Version: ${version}$'",
    notify  => Service['revealcloud'],
  }
  ->

  sysvinit::script { 'revealcloud':
    content           => template("${module_name}/init.sh"),
  }

  if $enable_node {
    exec { 'enable revealcloud node':
      command     => "/etc/init.d/revealcloud stop && ${dir}/revealcloud -x -a ${api_host} -k ${api_key} -E && /etc/init.d/revealcloud start",
      refreshonly => true,
      user        => '0',
      group       => '0',
      subscribe   => Sysvinit::Script['revealcloud'],
      before      => Service['revealcloud'],
    }
  }

  service { 'revealcloud':
    ensure  => running,
    enable  => true,
  }

  @monit::entry { 'revealcloud':
    content => template("${module_name}/monit"),
    require => Service['revealcloud']
  }
}
