node default {

  cgroups::cgconfig::mount {'cpu':
    path => '/sys/fs/cgroup/cpu'
  }

  cgroups::cgconfig::mount {'cpuset':
    path => '/sys/fs/cgroup/cpuset'
  }

  cgroups::cgconfig::mount {'cpuacct':
    path => '/sys/fs/cgroup/cpuacct'
  }

  cgroups::cgconfig::mount {'memory':
    path => '/sys/fs/cgroup/memory'
  }

  cgroups::cgconfig::mount {'devices':
    path => '/sys/fs/cgroup/devices'
  }

}
