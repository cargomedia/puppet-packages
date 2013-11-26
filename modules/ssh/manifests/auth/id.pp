define ssh::auth::id ($name, $user, $ssh_dir) {

  @@ssh::pair {$name:
    user => $user,
    ssh_dir => $ssh_dir,
    certname => $certname,
  }

  Ssh::Key <<| name == $name |>>
}
