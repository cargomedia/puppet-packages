class backup::server(
  $id
) {

  require 'rdiff_backup'

  ssh::auth::grant { "root@${::facts['clientcert']} for backup-agent@${id}":
    id   => "backup-agent@${id}",
    user => 'root',
  }

}
