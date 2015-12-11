class puppet::agent (
  $server = 'puppet',
  $masterport = 8140,
  $runinterval = '10m',
  $nice_value = '19',
  $splay = false,
  $splaylimit = undef,
  $environment = 'production',
) {

  require 'apt'
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
    ensure   => present,
    provider => 'apt',
    require  => [
      Helper::Script['install puppet apt sources'],
      Exec['/etc/puppet/puppet.conf'],
      File['/etc/puppet/conf.d/main']
    ]
  }
  ->

  daemon { 'puppet':
    binary => '/usr/bin/puppet',
    args   => 'agent --no-daemonize',
    nice   => $nice_value,
  }

  @bipbip::entry { 'puppet':
    plugin  => 'puppet',
    options => { },
  }
}
