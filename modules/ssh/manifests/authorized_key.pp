define ssh::authorized_key (
  $id = undef,
  $user,
  $content
) {

  require 'ssh'

  $key = extract_public_key($content)

  ssh_authorized_key { $title:
    ensure => present,
    user   => $user,
    type   => $key['type'],
    key    => $key['sha'],
  }
}
