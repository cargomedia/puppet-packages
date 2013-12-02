define ssh::pair ($user) {

  $keys = generate_sshkey($name)

  @@ssh::key {$name:
    user => $user,
    content => $keys[private],
  }

  @@ssh::key {"${name}.pub":
    user => $user,
    content => $keys[public],
  }

  @@ssh::authorized_key {$name:
    user => $user,
    content => $keys[public],
  }
}
