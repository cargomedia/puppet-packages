class puppet::agent (
  $server = 'puppet',
  $masterport = 8140,
  $runinterval = '10m',
  $nice_value = '19',
  $splay = false,
  $splaylimit = undef,
) {

  include 'puppet::common'

  $splaylimit_final = $splaylimit ? {
    undef => $runinterval,
    default => $splaylimit,
  }

  file {
    '/etc/puppet/conf.d/agent':
      ensure  => file,
      content => template("${module_name}/agent/config"),
      group   => '0',
      owner   => '0',
      mode    => '0644',
      notify  => Exec['/etc/puppet/puppet.conf'];

    '/etc/default/puppet':
      ensure  => file,
      content => template("${module_name}/agent/default"),
      group   => '0',
      owner   => '0',
      mode    => '0644',
      notify  => Service['puppet'];
  }
  ->

  package { 'puppet':
    ensure  => present,
    require => [
      Helper::Script['install puppet apt sources'],
      Exec['/etc/puppet/puppet.conf'],
      File['/etc/puppet/conf.d/main']
    ]
  }
  ->

  sysvinit::script { 'puppet':
    content           => template("${module_name}/agent/init"),
    require           => Package['puppet'],
  }

  service { 'puppet':
    enable    => true,
    subscribe => Exec['/etc/puppet/puppet.conf'],
  }

  @monit::entry { 'puppet':
    content => template("${module_name}/agent/monit"),
    require => Service['puppet'],
  }

  @bipbip::entry { 'puppet':
    plugin  => 'puppet',
    options => { },
  }

}
