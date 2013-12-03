define backup::ssh::id(
  $id
) {

  ssh::auth::id {$name:
    user => 'root'
  }
}
