class backup::server(
  $id
) {

  require 'rdiff-backup'

  ssh::auth::grant {"root@${clientcert} for backup-agent@${id}":
    id => "backup-agent@${id}",
    user => 'root',
  }

}
