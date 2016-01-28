define mongodb::mongorc::autologin (
  $database,
  $username,
  $password,
  $system_user_homepath = '/root/.mongorc.js'
) {

  mongodb::mongorc { "mongorc-autologin-${username}":
    content => template("${module_name}/mongorc/autologin"),
    path    => $system_user_homepath
  }
}
