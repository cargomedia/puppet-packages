class earlyoom (
  $percent_memory = '10',
  $percent_swap   = '10',
) {

  require 'git'

  $install_dir = '/usr/local/sbin'
  $unit_name = 'earlyoom.service'

  helper::script { 'install earlyoom':
    content => template("${module_name}/install.sh.erb"),
    unless  => "test -x ${install_dir}/earlyoom",
    before  => [Service[$unit_name], Systemd::Unit[$unit_name]],
  }

  service { $unit_name:
    ensure => running,
    enable => true,
  }

  systemd::unit { $unit_name:
    service_name => $unit_name,
    content      => template("${module_name}/${unit_name}.erb"),
  }

}
