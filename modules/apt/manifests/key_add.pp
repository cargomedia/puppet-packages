define apt::key_add($key, $key_url) {

  exec { "Add deb signature key for $name":
    command   => "wget -q '${key_url}' -O- | apt-key add -",
    path      => '/bin:/usr/bin',
    unless    => "/usr/bin/apt-key list | /bin/grep '${key}'",
    logoutput => 'on_failure',
  }

}
