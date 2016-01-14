class raid::linux_md {

  require 'apt'

  file { '/usr/local/sbin/md-status':
    ensure  => file,
    content => template("${module_name}/linux_md/md-status"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }

  @monit::entry { 'raid-md (Linux software RAID)':
    content => template("${module_name}/linux_md/monit"),
    require => File['/usr/local/sbin/md-status'],
  }

}
