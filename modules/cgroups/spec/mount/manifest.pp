node default {

  cgroups::mount {'cpu':
    path => '/sys/fs/cgroup/cpu'
  }

  cgroups::mount {'cpuset':
    path => '/sys/fs/cgroup/cpuset'
  }

  cgroups::mount {'cpuacct':
    path => '/sys/fs/cgroup/cpuacct'
  }

  cgroups::mount {'memory':
    path => '/sys/fs/cgroup/memory'
  }

  cgroups::mount {'devices':
    path => '/sys/fs/cgroup/devices'
  }

}
