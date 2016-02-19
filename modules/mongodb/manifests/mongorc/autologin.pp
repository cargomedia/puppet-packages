define mongodb::mongorc::autologin (
  $database,
  $username,
  $password,
  $user = 'root',
  $user_home = '/root'
) {

  file { "${user_home}/.mongorc.js":
    ensure   => file,
    content  => template("${module_name}/mongorc/autologin"),
    mode     => '0700',
    group    => $user,
    owner    => $user,
  }
}
