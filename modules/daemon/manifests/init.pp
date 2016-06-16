define daemon (
  $binary,
  $args = '',
  $user = 'root',
  $stop_timeout = 20,
  $nice = undef,
  $oom_score_adjust = undef,
  $env = { },
  $limit_nofile = undef,
  $core_dump = false,
  $sysvinit_kill = false,
  $pre_command = undef,
  $post_command = undef
) {

  $virtual = $::facts['virtual']
  $service_provider = $::facts['service_provider']

  if (defined(User[$user])) {
    User[$user] -> Daemon[$name]
  }

  if ($virtual == 'docker') {
    file { "/docker-run-${title}":
      ensure  => file,
      content => template("${module_name}/docker.sh.erb"),
      owner   => '0',
      group   => '0',
      mode    => '0755',
    }

  } else {
    service { $title:
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }

    if ($service_provider == 'debian') {
      sysvinit::script { $title:
        content => template("${module_name}/sysvinit.sh.erb"),
        notify  => Service[$title],
      }

      File <| title == $binary or path == $binary |> {
        before => Sysvinit::Script[$title],
      }

    }

    if ($service_provider == 'systemd') {
      systemd::unit { $title:
        content => template("${module_name}/systemd.service.erb"),
        notify  => Service[$title],
      }

      File <| title == $binary or path == $binary |> {
        before => Systemd::Unit[$title],
      }

      file { "/usr/local/bin/${title}-status":
        ensure  => file,
        content => template("${module_name}/service_status.sh.erb"),
        owner   => '0',
        group   => '0',
        mode    => '0755',
      }
    }

    @monit::entry { $title:
      content => template("${module_name}/monit.${service_provider}.erb"),
      require => Service[$title],
    }
  }

}
