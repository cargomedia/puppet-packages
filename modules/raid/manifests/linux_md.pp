class raid::linux_md {

  require 'apt'

  if ($::lsbdistcodename == 'vivid') {
    $mdamd_service_name = 'mdadm'
  } else {
    $mdamd_service_name = 'mdadm-raid'
  }

  file { '/etc/mdadm':
    ensure => directory,
    group  => '0',
    owner  => '0',
    mode   => '0755',
  }

  file { '/etc/mdadm/mdadm.conf':
    ensure  => file,
    content => template("${module_name}/linux_md/mdadm.conf"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    notify  => Service[$mdamd_service_name],
    before  => Package['mdadm'],
  }

  file { '/tmp/mdadm.preseed':
    ensure  => file,
    content => template("${module_name}/linux_md/mdadm.preseed"),
    mode    => '0644',
  }

  package { 'mdadm':
    ensure       => present,
    provider     => 'apt',
    responsefile =>  '/tmp/mdadm.preseed',
    require      => File['/tmp/mdadm.preseed'],
  }
  ->

  service { $mdamd_service_name:
    hasstatus => false,
    enable    => true,
  }

  @monit::entry { 'mdadm-status':
    content => template("${module_name}/linux_md/monit.${facts['service_provider']}.erb"),
    require => Service[$mdamd_service_name],
  }
}
