define composer::project (
  $target,
  $version,
  $user = 'root',
  $home = '/root',
  $stability = 'stable',
) {
  require 'composer'

  exec {"install ${name}":
    command => "composer --no-interaction create-project ${name} --stability=${stability} --keep-vcs ${target}",
    creates => $target,
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user => $user,
    environment => ["HOME=${home}"],
    require => Class['composer'],
  }
  ->

  exec {"upgrade ${name}":
    command => "git fetch && git checkout ${version} && composer --no-interaction --no-dev install",
    cwd => $target,
    unless => "test $(git rev-parse HEAD) = $(git rev-parse ${version})",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user => $user,
    environment => ["HOME=${home}"],
    require => Class['composer'],
  }
}
