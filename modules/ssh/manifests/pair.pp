define ssh::pair ($user, $ssh_dir, $fqdn) {

  $path = shellquote("/var/lib/puppet/ssh-repository/${fqdn}/id_rsa")
  $keys = generate_sshkey($path)

  @@ssh::key {$name:
    user => $user,
    ssh_dir => $ssh_dir,
    content => $keys[private],
  }

  @@ssh::authorized_key {$name:
    user => $user,
    content => $keys[public],
  }
}
