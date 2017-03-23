class fluentd {

  $fluentd_version = '0.14.13'

  ruby::gem { 'fluentd':
    ensure => $fluentd_version,
    notify  => Daemon['fluentd'],
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

  user { 'fluentd':
    ensure => present,
    groups => ['systemd-journal'],
    system => true,
  }

  daemon { 'fluentd':
    binary        => '/usr/local/bin/fluentd',
    args          => '-c /etc/fluentd/fluent.conf --no-supervisor',
    user          => 'fluentd',
    require       => [Ruby::Gem['fluentd'], File['/etc/fluentd/fluent.conf'], User['fluentd']],
  }

  Fluentd::Config <||>
  Fluentd::Config::Source_tail <||>
}
