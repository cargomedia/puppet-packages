class raid::linux_md {

  require 'apt'

  if ($::facts['lsbdistcodename'] == 'vivid') {
    $mdadm_service_name = 'mdadm'
  } else {
    $mdadm_service_name = 'mdadm-raid'
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
    notify  => Service[$mdadm_service_name],
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
    responsefile => '/tmp/mdadm.preseed',
    require      => File['/tmp/mdadm.preseed'],
  }

  service { $mdadm_service_name:
    hasstatus => false,
    enable    => true,
    require   => Package['mdadm'],
  }

  @bipbip::entry { "raid-${mdadm_service_name}":
    plugin  => 'command-status',
    options => {
      command => "/bin/systemctl is-active ${mdadm_service_name} 1>/dev/null",
    },
    require => Service[$mdadm_service_name],
  }
}
