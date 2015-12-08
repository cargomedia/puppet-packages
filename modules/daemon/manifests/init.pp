define daemon (
  $binary,
  $args = '',
  $user = 'root',
) {

  service { $title:
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  if ($::operatingsystem == 'debian' and $::operatingsystemmajrelease in [7]) {
    sysvinit::script { $title:
      content => template("${module_name}/sysvinit.sh.erb"),
      notify  => Service[$title],
    }

    File <| title == $binary or path == $binary |> {
      before => Sysvinit::Script[$title],
    }
  }

  if ($::operatingsystem == 'ubuntu' and $::operatingsystemmajrelease in ['15.04']) {
    systemd::unit { $title:
      content => template("${module_name}/systemd.service.erb"),
      notify  => Service[$title],
    }

    File <| title == $binary or path == $binary |> {
      before => Systemd::Unit[$title],
    }
  }

}
