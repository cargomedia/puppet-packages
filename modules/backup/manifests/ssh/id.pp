define backup::ssh::id(
  $id
) {

  ssh::auth::id {$name:
    id => "backup-agent@${id}",
    user => 'root',
  }
}
