define mongodb::mongorc::autologin (
  $database,
  $username,
  $password,
  $path = '/etc/mongorc.js'
) {

  file { $path:
    ensure   => file,
    content  => template("${module_name}/mongorc/autologin"),
    mode     => '0700',
    group    => '0',
    owner    => '0',
  }
}
