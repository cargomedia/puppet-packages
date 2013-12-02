define ssh::authorized_key ($user, $content) {

  require 'ssh'

  $key = extract_public_key($content)

  ssh_authorized_key {$name:
    ensure => present,
    user => $user,
    type => $key[type],
    key => $key[sha],
  }
}
