define ssh::knownhost ($key, $aliases = []) {

  sshkey {$title:
    host_aliases => $aliases,
    ensure => present,
    key => $key,
    type => 'ssh-rsa',
  }
}
