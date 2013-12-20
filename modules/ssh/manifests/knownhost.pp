define ssh::knownhost($hostname = $title, $key, $aliases = []) {

  sshkey {$title:
    name => $hostname,
    host_aliases => $aliases,
    ensure => present,
    key => $key,
    type => 'ssh-rsa',
  }
}
