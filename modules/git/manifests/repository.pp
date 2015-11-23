define git::repository (
  $remote,
  $directory,
  $revision,
  $user = 'root',
) {

  require 'git'

  exec { "git clone ${name}":
    command     => "git clone -v '${remote}' '${directory}'",
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    creates     => $directory,
    user        => $user,
    logoutput   => true,
  }
  ->

  exec { "git fetch ${name}":
    command     => "git fetch && git checkout '${revision}'",
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    cwd         => $directory,
    unless      => "test $(git rev-list -1 HEAD) = $(git rev-list -1 '${revision}')",
    user        => $user,
  }

}
