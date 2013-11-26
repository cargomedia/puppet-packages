define ssh::auth::id ($name, $user, $ssh_dir) {

  @@ssh::pair {$name:
    user => $user,
    ssh_dir => $ssh_dir,
    certname => $certname,
  }

  realize Ssh::Key[$name]
}
