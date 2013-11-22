define ssh::keyinstall(
  $user,
  $homedir = undef
) {

  if !$homedir {
    $_homedir = $user ? { "root" => '/root', default => undef }
  } else {
    $_homedir = $homedir
  }

  notify{$_homedir:}

  ssh::sshkeys::set_client_key_pair {"$title":
      user => $user,
      keyname => "$user@$hostname",
      home => $_homedir
  }
}
