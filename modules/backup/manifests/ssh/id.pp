define backup::ssh::id(
  $id
) {

  ssh::auth::id {$name:
    id => $id,
    user => 'root',
  }
}
