define ssh::auth::id ($user) {

  @@ssh::pair {$name:
    user => $user,
  }

  Ssh::Key <<| title == $title |>>
  Ssh::Key <<| title == "${title}.pub" |>>

  $knownhost_tag = md5("ssh::auth ${name}")
  Ssh::Knownhost <<| tag == $knownhost_tag |>>
}
