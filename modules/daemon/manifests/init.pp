define daemon (
  $binary,
  $args = '',
  $user = 'root',
  $stop_timeout = 20,
  $nice = undef,
  $oom_score_adjust = undef,
  $env = {},
  $limit_nofile = undef,
  $core_dump = false,
  $sysvinit_kill = false,
) {

  if (defined(User[$user])) {
    User[$user] -> Daemon[$name]
  }

  Service {
    provider => $::service_provider,
  }

  service { $title:
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  if ($::service_provider == 'debian') {
    sysvinit::script { $title:
      content => template("${module_name}/sysvinit.sh.erb"),
      notify  => Service[$title],
    }

    File <| title == $binary or path == $binary |> {
      before => Sysvinit::Script[$title],
    }

  }

  if ($::service_provider == 'systemd') {
    systemd::unit { $title:
      content => template("${module_name}/systemd.service.erb"),
      notify  => Service[$title],
    }

    File <| title == $binary or path == $binary |> {
      before => Systemd::Unit[$title],
    }
  }

  @monit::entry { $title:
    content => template("${module_name}/monit.${::service_provider}.erb"),
    require => Service[$title],
  }
}
