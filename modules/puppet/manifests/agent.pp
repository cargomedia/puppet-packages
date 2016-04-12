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
    '/etc/puppetlabs/puppet/conf.d/agent':
      ensure  => file,
      content => template("${module_name}/agent/config"),
      group   => '0',
      owner   => '0',
      mode    => '0644',
      notify  => Exec['/etc/puppetlabs/puppet/puppet.conf'];
  }
  ->

  package { 'puppet-agent':
    ensure   => present,
    provider => 'apt',
    require  => [
      Helper::Script['install puppet apt sources'],
      Exec['/etc/puppetlabs/puppet/puppet.conf'],
      File['/etc/puppetlabs/puppet/conf.d/main']
    ]
  }
  ->

  daemon { 'puppet':
    binary  => '/usr/bin/puppet',
    args    => 'agent --no-daemonize',
    nice    => $nice_value,
    require => File['/usr/bin/puppet'],
  }

  file {
    '/usr/bin/puppet':
      ensure  => 'link',
      target  => '/opt/puppetlabs/bin/puppet',
      require => Package['puppet-agent'];
    '/usr/bin/facter':
      ensure  => 'link',
      target  => '/opt/puppetlabs/bin/facter',
      require => Package['puppet-agent'];
    '/usr/bin/mco':
      ensure  => 'link',
      target  => '/opt/puppetlabs/bin/mco',
      require => Package['puppet-agent'];
    '/usr/bin/hiera':
      ensure  => 'link',
      target  => '/opt/puppetlabs/bin/hiera',
      require => Package['puppet-agent'];
  }

  @bipbip::entry { 'puppet':
    plugin  => 'puppet',
    options => {
      lastrunfile => '/opt/puppetlabs/puppet/cache/state/last_run_summary.yaml',
    },
  }
}
