define ssh::keyauthorized(
  $user,
  $homeDir = undef
) {

  if !$homeDir {
    $_homedir = $user ? { 'root' => '/root', default => undef }
  }

  ssh::sshkeys::set_authorized_keys {$title:
    user  => $user,
    home  => $_homedir
  }

}
