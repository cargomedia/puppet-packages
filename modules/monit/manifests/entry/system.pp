class monit::entry::system(
  $alertOnLoad1 = undef,
  $alertOnLoad5 = undef,
  $alertOnLoad15 = undef
) {

  require '::monit'

  @monit::entry { 'system':
    content => template("${module_name}/entry/system"),
  }
}
