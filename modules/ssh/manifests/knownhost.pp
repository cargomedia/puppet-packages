define ssh::knownhost ($key) {

  sshkey {$name:
    ensure => present,
    key => $key,
    type => 'ssh-rsa',
  }
}
