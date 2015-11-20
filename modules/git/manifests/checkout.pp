define git::checkout (
  $repository,
  $directory,
  $version,
  $user = 'root',
) {

  require 'git'

  exec { "git clone ${name}":
    command     => "git clone -v '${repository}' '${directory}'",
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    creates     => $directory,
    user        => $user,
    logoutput   => true,
  }
  ->

  exec { "git fetch ${name}":
    command     => "git fetch && git checkout '${version}'",
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    cwd         => $directory,
    unless      => "test $(git rev-list -1 HEAD) = $(git rev-list -1 '${version}')",
    user        => $user,
  }

}
