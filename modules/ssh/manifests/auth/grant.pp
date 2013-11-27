define ssh::auth::grant ($user, $hosts = []) {

  Ssh::Authorized_key <<| title == $title |>> {
    user => $user,
  }

  @@ssh::knownhost {$hosts:
    key => $sshrsakey,
    tag => md5("ssh::auth ${name}"),
  }
}
