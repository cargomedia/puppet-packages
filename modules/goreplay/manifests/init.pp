class goreplay( $version = '0.15.1') {

  helper::script { 'install goreplay':
    content => template("${module_name}/install.sh.erb"),
    unless  => 'which gor',
  }
}