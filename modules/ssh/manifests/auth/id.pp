define ssh::auth::id ($user) {

  @@ssh::pair {"${name}@${fqdn}":
    id => $name,
    user => $user,
  }

  Ssh::Key <<| title == $title |>>
  Ssh::Key <<| title == "${title}.pub" |>>
}
