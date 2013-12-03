class backup::ssh::grant(
  $id
) {

  ssh::auth::grant {"root@${fqdn} for backup-agent@${id}":
    id => "backup-agent@${id}",
    user => 'root',
  }
}
