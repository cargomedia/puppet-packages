define daemon (
  $binary,
  $args = '',
  $user = 'root',
) {

  Service {
    provider => $::init_system,
  }

  service { $title:
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  if ($::init_system == 'sysvinit') {
    sysvinit::script { $title:
      content => template("${module_name}/sysvinit.sh.erb"),
      notify  => Service[$title],
    }

    File <| title == $binary or path == $binary |> {
      before => Sysvinit::Script[$title],
    }
  }

  if ($::init_system == 'systemd') {
    systemd::unit { $title:
      content => template("${module_name}/systemd.service.erb"),
      notify  => Service[$title],
    }

    File <| title == $binary or path == $binary |> {
      before => Systemd::Unit[$title],
    }
  }

}
