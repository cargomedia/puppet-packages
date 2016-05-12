class fluentd {

  ruby::gem { 'fluentd':
    ensure => latest,
  }

  file { '/etc/fluentd':
    ensure  => directory,
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }

  file { '/etc/fluentd/fluent.conf':
    ensure  => file,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    content => template("${module_name}/fluent.conf.erb"),
    notify  => Daemon['fluentd'],
  }

  file { '/etc/fluentd/config.d':
    ensure  => directory,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    purge   => true,
    recurse => true,
  }

  file { '/var/lib/fluentd':
    ensure => directory,
    owner  => 'fluentd',
    group  => 'fluentd',
    mode   => '0644',
  }

  file { '/var/lib/fluentd/tail_pos':
    ensure => file,
    owner  => 'fluentd',
    group  => 'fluentd',
    mode   => '0644',
  }

  file { '/var/log/fluentd':
    ensure => directory,
    owner  => 'fluentd',
    group  => 'fluentd',
    mode   => '0644',
  }

  logrotate::entry { $module_name:
    path    => '/var/log/fluentd/*.log',
  }

  user { 'fluentd':
    ensure => present,
    system => true,
  }

  daemon { 'fluentd':
    binary        => '/usr/local/bin/fluentd',
    args          => '-c /etc/fluentd/fluent.conf -o /var/log/fluentd/fluentd.log --no-supervisor',
    user          => 'fluentd',
    sysvinit_kill => true,
    require       => [Ruby::Gem['fluentd'], File['/etc/fluentd/fluent.conf'], File['/var/log/fluentd'], User['fluentd']],
  }

  Fluentd::Config::Match <||>
  Fluentd::Config::Source <||>
  Fluentd::Config::Source_tail <||>

}
