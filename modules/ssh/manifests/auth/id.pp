define ssh::auth::id ($user, $ssh_dir) {

  @@ssh::pair {$name:
    user => $user,
    ssh_dir => $ssh_dir,
    fqdn => $fqdn,
  }

  Ssh::Key <<| title == $title |>>
}
