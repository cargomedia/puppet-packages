define ssh::knownhost($hostname = $title, $key, $aliases = []) {

  sshkey {$title:
    ensure => present,
    name => $hostname,
    host_aliases => $aliases,
    key => $key,
    type => 'ssh-rsa',
  }
}
