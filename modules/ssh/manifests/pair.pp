define ssh::pair ($user, $ssh_dir) {

  $keys = generate_sshkey("/var/lib/puppet/ssh-repository/${name}_rsa")

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
