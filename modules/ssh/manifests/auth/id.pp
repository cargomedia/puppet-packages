define ssh::auth::id (
  $id = $title,
  $user
) {

  @@ssh::pair {"${title}@${fqdn}":
    id => $id,
    user => $user,
  }

  Ssh::Key <<| id == $id |>>
  Ssh::Key <<| id == "${id}.pub" |>>
}
