class goreplay ($version = '0.15.1') {

  $regexed_version = regsubst($version, '\.', '\\.', 'G')

  helper::script { 'install goreplay':
    content => template("${module_name}/install.sh.erb"),
    unless  => "/usr/local/bin/gor 2>/dev/null | grep -E '^Version: v${regexed_version}'",
  }

}