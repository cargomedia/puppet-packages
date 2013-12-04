define ssh::auth::grant ($id, $user) {

  Ssh::Authorized_key <<| id == $id |>> {
    user => $user,
  }
}
