define ssh::pair ($user, $ssh_dir, $certname) {

  $path = shellquote("/var/lib/ssh-repository/${certname}")
  $keyfile = "${path}/id_rsa"

  exec("if (test -f ${keyfile}); then ssh-keygen -t ssh-rsa -f ${keyfile}; fi")
  exec("mkdir -p ${path}; ")

  $key_private = file($keyfile)
  $key_public = file("${keyfile}.pub")

  @@ssh::key {$name:
    user => $user,
    ssh_dir => $ssh_dir,
    content => $key_private,
  }

  @@ssh::authorized_key {$name:
    user => $user,
    content => $key_public,
  }
}
