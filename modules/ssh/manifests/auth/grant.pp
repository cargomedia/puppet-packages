define ssh::auth::grant ($name, $user) {

  Ssh::Authorized_key <<| name == $name |>> {
    user => $user,
  }
}
