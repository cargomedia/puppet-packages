class copperegg_revealcloud(
  $api_key,
  $label = $::facts['clientcert'],
  $tags = [],
  $version = 'v3.3-118-g5f871c6',
  $enable_node = true
) {

  $hiera_tag_list = lookup('tags', Array, 'unique', [])
  $facts_tag_list = $::facts['copperegg_tags']
  $server_tag_list = concat($tags, $hiera_tag_list, $facts_tag_list)

  $dir = '/usr/local/revealcloud'
  $api_host = 'api.copperegg.com'
  $tag_list = $server_tag_list ? { undef => [], default => $server_tag_list }

  case $::facts['architecture'] {
    i386: { $url = "http://cdn.copperegg.com/revealcloud/${version}/linux-2.6/i386/revealcloud" }
    amd64: { $url = "http://cdn.copperegg.com/revealcloud/${version}/linux-2.6/x86_64/revealcloud" }
    default: { fail('Unrecognized architecture') }
  }

  file {
    $dir:
      ensure => directory,
      owner  => '0',
      group  => '0',
      mode   => '0644';
    "${dir}/run":
      ensure => directory,
      owner  => '0',
      group  => '0',
      mode   => '0644';
    "${dir}/log":
      ensure => directory,
      owner  => '0',
      group  => '0',
      mode   => '0644';
  }

  exec { 'download revealcloud':
    provider    => shell,
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    command     => template("${module_name}/download.sh"),
    unless      => "test -x ${dir}/revealcloud && ${dir}/revealcloud -V 2>&1 | grep 'Version: ${version}$'",
    require     => File[$dir],
    notify      => Daemon['revealcloud'],
  }

  if $enable_node {
    exec { 'enable revealcloud node':
      path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
      command     => "rm -f /usr/local/revealcloud/run/revealcloud.pid && ${dir}/revealcloud -x -a ${api_host} -k ${api_key} -E",
      unless      => "test -e ${dir}/enabled.lock",
      user        => '0',
      group       => '0',
      before      => Daemon['revealcloud'],
    }
    ->
    file { "${dir}/enabled.lock":
      ensure => file,
    }
  }

  daemon { 'revealcloud':
    binary           => "${dir}/revealcloud",
    args             => template("${module_name}/daemon_args.erb"),
    oom_score_adjust => -1000,
    require          => Exec['download revealcloud'],
  }

}
