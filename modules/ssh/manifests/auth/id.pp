define ssh::auth::id ($name, $user, $sshDir) {

  @@ssh::pair {$name:
    user => $user,
    sshDir => $sshDir,
    certname => $certname,
  }

  realize Ssh::Key[$name]
}
