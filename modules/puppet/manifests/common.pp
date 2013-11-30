class puppet::common {

  helper::script {'install puppet apt sources':
    content => template('puppet/install-apt-sources.sh'),
    unless => "dpkg -l puppetlabs-release | grep '^ii '",
  }

  file {'/etc/puppet':
    ensure => directory,
    group => '0',
    owner => '0',
    mode => '0755',
  }

  file {'/etc/puppet/conf.d':
    ensure => directory,
    group => '0',
    owner => '0',
    mode => '0755',
  }

  file {'/etc/puppet/conf.d/main':
    ensure => file,
    content => template('puppet/config'),
    group => '0',
    owner => '0',
    mode => '0644',
    notify => Exec['/etc/puppet/conf.d/main-modulepath'],
  }

  exec {'/etc/puppet/conf.d/main-modulepath':
    command => 'MODULEPATH=$(ls -d -1 /etc/puppet/repos/* | perl -pe \'s/(.*)\n/:$1\/modules/\'); echo "modulepath = /etc/puppet/modules:/usr/share/puppet/modules$MODULEPATH" > /etc/puppet/conf.d/main-modulepath',
    provider => 'shell',
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
    require => File['/etc/puppet/conf.d'],
    notify => Exec['/etc/puppet/puppet.conf'],
  }

  exec {'/etc/puppet/puppet.conf':
    command => "cat /etc/puppet/conf.d/* > /etc/puppet/puppet.conf",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
    require => File['/etc/puppet'],
  }

  ruby::gem {'deep_merge':
    ensure => present,
  }

  puppet::module {'puppetlabs/stdlib': }
}
