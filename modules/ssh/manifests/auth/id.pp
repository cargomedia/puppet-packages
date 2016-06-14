define ssh::auth::id (
  $id = $title,
  $user
) {

  @@ssh::pair { "${title}@${::facts['fqdn']}":
    id   => $id,
    user => $user,
    fqdn => $::facts['fqdn'],
  }

  Ssh::Key <<| fqdn == $::facts['fqdn'] and id == $id |>>
  Ssh::Key <<| fqdn == $::facts['fqdn'] and id == "${id}.pub" |>>
}
