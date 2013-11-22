define ssh::keyinstall(
  $user,
  $homeDir = undef
) {

  if !$homeDir {
    $_homedir = $user ? { 'root' => '/root', default=> "/home/${user}" }
  } else {
    $_homedir = $homeDir
  }

  user {$user:
    ensure => present,
    home => $_homedir,
    managehome => true,
  }

  ssh::sshkeys::set_client_key_pair {$title:
      user => $user,
      home => $_homedir
  }
}
