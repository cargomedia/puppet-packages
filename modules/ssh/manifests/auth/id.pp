define ssh::auth::id (
  $id = $title,
  $user
) {

  @@ssh::pair {"${title}@${fqdn}":
    id => $id,
    user => $user,
    fqdn => $fqdn,
  }

  Ssh::Key <<| fqdn == $fqdn and id == $id |>>
  Ssh::Key <<| fqdn == $fqdn and id == "${id}.pub" |>>
}
