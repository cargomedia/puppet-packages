class raid::linux-md {

  file { '/etc/mdadm/mdadm.conf':
    ensure => file,
    content => template('raid/linux-md/mdadm.conf'),
    group => '0',
    owner => '0',
    mode => '0644',
    notify => Service['mdadm'],
    before => Package['mdadm'],
  }

  package { 'mdadm':
    ensure => present
  }
  ->

  service { 'mdadm':
    hasstatus => false,
  }
  ->

  monit::entry {'mdadm-status':
    content => template('raid/linux-md/monit')
  }

}