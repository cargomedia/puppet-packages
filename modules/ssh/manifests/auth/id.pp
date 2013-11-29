define ssh::auth::id ($user) {

  @@ssh::pair {$name:
    user => $user,
  }

  Ssh::Key <<| title == $title |>>
  Ssh::Key <<| title == "${title}.pub" |>>
}
