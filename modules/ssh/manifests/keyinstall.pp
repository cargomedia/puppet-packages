define ssh::keyinstall($user, $homedir = undef) {

  # ssh::keycreate{"$user@$hostname":  }

  if !$homedir {
    $_homedir = $user ? { "root" => '/root', default => undef }
  }

  sshkeys::set_client_key_pair {"$title":
      user => $user,
      keyname => "$user@$hostname",
      home => $_homedir
  }
}
