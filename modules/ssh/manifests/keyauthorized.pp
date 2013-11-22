define ssh::keyauthorized($user, $homeDir = undef) {

  if !$homeDir {
    $_homedir = $user ? { "root" => '/root', default => undef}
  }

  sshkeys::set_authorized_keys{"$title":
    keyname => $keyname,
    user    => $user,
    home    => $_homedir
  }

}
