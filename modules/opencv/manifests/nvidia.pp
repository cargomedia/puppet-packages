class opencv::nvidia {

  require 'cuda'
  require 'opencv::source'

  helper::script { 'install opencv with cuda':
    content => template("${module_name}/install.sh"),
    unless  => "",
  }
}
