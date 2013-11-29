define ssh::knownhost ($key, $aliases = []) {

  sshkey {$name:
    host_aliases => $aliases,
    ensure => present,
    key => $key,
    type => 'ssh-rsa',
  }
}
