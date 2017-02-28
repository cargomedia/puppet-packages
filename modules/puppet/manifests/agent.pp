class puppet::agent (
  $server = 'puppet',
  $masterport = 8140,
  $runinterval = '10m',
  $nice_value = '19',
  $splay = false,
  $splaylimit = undef,
  $environment = 'production',
) {

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

  daemon { 'puppet':
    binary  => '/opt/puppetlabs/bin/puppet',
    args    => 'agent --no-daemonize',
    nice    => $nice_value,
    require => Package['puppet-agent'];
  }

  @bipbip::entry { 'puppet':
    plugin  => 'puppet',
    options => {
      lastrunfile => '/opt/puppetlabs/puppet/cache/state/last_run_summary.yaml',
    },
  }
}
