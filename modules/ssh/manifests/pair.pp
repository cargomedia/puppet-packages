define ssh::pair (
  $id,
  $user,
  $fqdn
) {

  $keys = generate_sshkey($id)

  @@ssh::key { $title:
    user    => $user,
    content => $keys['private'],
    id      => $id,
    fqdn    => $fqdn,
  }

  @@ssh::key { "${title}.pub":
    user    => $user,
    content => $keys['public'],
    id      => $id,
    fqdn    => $fqdn,
  }

  @@ssh::authorized_key { $title:
    id      => $id,
    user    => $user,
    content => $keys['public'],
  }
}
