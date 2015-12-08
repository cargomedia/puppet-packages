define daemon (
  $binary,
  $args = '',
  $user = 'root',
) {

  service { $title:
    enable    => true,
  }

  if ($::operatingsystem == 'debian' and $::operatingsystemmajrelease in [7]) {
    sysvinit::script { $title:
      content => template("${module_name}/sysvinit.sh.erb"),
      notify  => Service[$title],
    }
  }

}
