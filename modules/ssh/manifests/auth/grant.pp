define ssh::auth::grant ($id, $user) {

  Ssh::Authorized_key <<| title == $id |>> {
    user => $user,
  }
}
