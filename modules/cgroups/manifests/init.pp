class cgroups {

  # TO DO
  # install cgconfigd daemon; install groups
  # -> load /etc/cgconfig.conf
  # -> does cgcreate
  # -> set params for groups
  # -> mount stuff
  #
  # install cgred daemon; watch all process and moves to right groups
  # -> load /etc/cgrules.conf
  # -> load /etc/cgred.conf

  package {'cgroup-bin':
    ensure => present,
  }

}
