define sysctl::entry($sysctlFile, $value) {

  include 'sysctl'

  $context = "/files$sysctlFile"
  $key = $title

  augeas { "Set $key in sysctl.d":
    incl => $sysctlFile,
    lens => 'Sysctl.lns',
    changes => "set $key '$value'",
    context => $context,
    notify  => Exec["sysctl"],
  }
}
