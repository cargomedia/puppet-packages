class cgroups (
  $config_file_path = '/etc/cgconfig.conf'
) {

  # install cgconfig daemon
  # -> load /etc/cgconfig.conf
  # -> does mainlly cgcreate

  # install cgred daemon; watch all process and moves to right groups
  # -> load /etc/cgrules.conf
  # -> load /etc/cgred.conf

  package {'cgroup-bin':
    ensure => present,
  }

}
