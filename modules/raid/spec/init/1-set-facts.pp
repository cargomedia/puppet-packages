node default {

  file { ['/etc/facter', '/etc/facter/facts.d']:
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }

  file { '/etc/facter/facts.d/raid.txt':
    ensure  => file,
    content => 'raid=raid::adaptec,raid::sas2ircu',
    owner   => '0',
    group   => '0',
    mode    => '0644';
  }
}
