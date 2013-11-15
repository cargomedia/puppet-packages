define environment::variable ($value) {

  require 'environment'

  $escapedValue = shellquote($value)
  $code = "${name}=${escapedValue}"

  exec {"/etc/environment ${name}":
    command => "sed -i '/${name}=/ d' /etc/environment && echo ${code} >> /etc/environment",
    unless => "grep ^${code}$ /etc/environment",
  }
}
