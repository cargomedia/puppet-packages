define ssh::auth::grant ($user) {

  Ssh::Authorized_key <<| title == $title |>> {
    user => $user,
  }
}
