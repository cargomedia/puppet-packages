define daemon (
  $binary,
  $args = '',
  $user = 'root',
  $stop_timeout = 20,
  $nice = undef,
  $oom_score_adjust = undef,
  $env = { },
  $limit_nofile = undef,
  $limit_fsize = undef,
  $limit_cpu = undef,
  $limit_as = undef,
  $limit_rss = undef,
  $limit_nproc = undef,
  $core_dump = false,
  $pre_command = undef,
  $post_command = undef,
  $runtime_directory = undef,
  $runtime_directory_mode = undef,
  $critical = true,
) {

  $virtual = $::facts['virtual']

  if (defined(User[$user])) {
    User[$user] -> Daemon[$name]
  }

  if ($virtual == 'docker') {
    file { "/docker-run-${name}":
      ensure  => file,
      content => template("${module_name}/docker.sh.erb"),
      owner   => '0',
      group   => '0',
      mode    => '0755',
    }

  } else {
    service { $name:
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }

    systemd::service { $name:
      content => template("${module_name}/systemd.service.erb"),
      critical => $critical,
    }

    File <| title == $binary or path == $binary |> {
      before => Systemd::Service[$name],
    }
  }

}
