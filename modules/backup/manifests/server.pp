class backup::server(
  $id
) {

  require 'rdiff-backup'

  ssh::auth::grant {"root@${fqdn} for backup-agent@${id}":
    id => "backup-agent@${id}",
    user => 'root',
  }

}
