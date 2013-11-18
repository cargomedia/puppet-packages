class ssh {

  file {'/etc/ssh/ssh_config':
    ensure => file,
    content => template('ssh/ssh_config'),
    owner => '0',
    group => '0',
    mode => '0644',
    before => Package['ssh'],
  }

  file {'/etc/ssh/sshd_config':
    ensure => file,
    content => template('ssh/sshd_config'),
    owner => '0',
    group => '0',
    mode => '0644',
    before => Package['ssh'],
    notify => Service['ssh'],
  }

  package {'ssh':
    ensure => installed,
    before => Service['ssh'],
  }

  service {'ssh':}
}
