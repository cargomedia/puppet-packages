class earlyoom(
  $percent_memory = '10',
  $percent_swap = '10',
) {

  require 'git'

  $install_dir = '/usr/local/sbin'

  helper::script { 'install earlyoom':
    content => template("${module_name}/install.sh.erb"),
    unless => "test -x ${install_dir}/earlyoom",
  }

  daemon { 'earlyoom':
    binary => "${install_dir}/earlyoom -m ${percent_memory} -s ${percent_swap} >/dev/null",
    require => Helper::Script['install earlyoom'],
  }

}
