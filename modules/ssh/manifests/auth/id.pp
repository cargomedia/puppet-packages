define ssh::auth::id ($user, $ssh_dir) {

  @@ssh::pair {$name:
    user => $user,
    ssh_dir => $ssh_dir,
  }

  Ssh::Key <<| title == $title |>>

  $knownhost_tag = md5("ssh::auth ${name}")
  Ssh::Knownhost <<| tag == $knownhost_tag |>>
}
