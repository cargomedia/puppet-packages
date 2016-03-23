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
    notify  => Service['fluentd'],
  }

  file { '/etc/fluentd/config.d':
    ensure  => directory,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    purge   => true,
    recurse => true,
  }

  file { '/var/log/fluentd':
    ensure => directory,
    owner  => 'fluentd',
    group  => 'fluentd',
    mode   => '0644',
  }

  logrotate::entry{ $module_name:
    content => template("${module_name}/logrotate"),
  }

  user { 'fluentd':
    ensure => present,
    system => true,
  }

  daemon { 'fluentd':
    binary  => '/usr/local/bin/fluentd',
    args    => '-c /etc/fluentd/fluent.conf -o /var/log/fluentd/fluentd.log --no-supervisor',
    user    => 'fluentd',
    require => [Ruby::Gem['fluentd'], File['/etc/fluentd/fluent.conf'], File['/var/log/fluentd'], User['fluentd']],
  }

  Fluentd::Config::Source <||>
  Fluentd::Config::Match <||>

}
