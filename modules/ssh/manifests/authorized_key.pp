define ssh::authorized_key ($user, $content) {

  require 'ssh'

  ssh_authorized_key {$name:
    ensure => present,
    user => $user,
    type => 'ssh-rsa',
    key => $content,
  }
}
