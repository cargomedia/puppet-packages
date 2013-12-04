define ssh::pair (
  $id,
  $user
) {

  $keys = generate_sshkey($id)

  @@ssh::key {$title:
    id => $id,
    user => $user,
    content => $keys[private],
  }

  @@ssh::key {"${title}.pub":
    id => $id,
    user => $user,
    content => $keys[public],
  }

  @@ssh::authorized_key {$title:
    id => $id,
    user => $user,
    content => $keys[public],
  }
}
