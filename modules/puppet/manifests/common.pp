class puppet::common (
  $basemodulepath = '/etc/puppetlabs/code/modules',
  $gems           = [
    'deep_merge',
    'ipaddress',
  ],
) {

  require 'apt'

  helper::script { 'install puppet apt sources':
    content => template("${module_name}/install-apt-sources.sh"),
    unless  => "dpkg-query -f '\${Status}\n' -W puppetlabs-release-pc1 | grep -q 'ok installed'",
    require => Class['apt::update'],
  }

  package { 'puppet-agent':
    ensure   => present,
    provider => 'apt',
    require  => [
      Helper::Script['install puppet apt sources'],
      Exec['/etc/puppetlabs/puppet/puppet.conf'],
    ]
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
    ['/etc/puppetlabs', '/etc/puppetlabs/puppet', '/etc/puppetlabs/code',
      '/opt/puppetlabs/puppet/cache']:
      ensure => directory,
      group  => '0',
      owner  => '0',
      mode   => '0644';
    '/etc/puppetlabs/puppet/conf.d':
      ensure  => directory,
      group   => '0',
      owner   => '0',
      mode    => '0644',
      purge   => true,
      recurse => true;
    '/etc/puppetlabs/puppet/conf.d/main':
      ensure  => file,
      content => template("${module_name}/config"),
      group   => '0',
      owner   => '0',
      mode    => '0644',
      notify  => Exec['/etc/puppetlabs/puppet/puppet.conf'],
  }

  exec { '/etc/puppetlabs/puppet/puppet.conf':
    command     => 'cat /etc/puppetlabs/puppet/conf.d/* > /etc/puppetlabs/puppet/puppet.conf',
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
    require     => File['/etc/puppetlabs/puppet'],
  }

  puppet::gem { $gems: }

}
