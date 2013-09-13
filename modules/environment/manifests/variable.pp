define environment::variable ($value) {

  require 'environment'

  $escapedValue = shellquote($value)
  $code = "${name}=${escapedValue}"

  exec {"/etc/environment ${name}":
    command => "sed -i '/${name}=/ d' /etc/environment && echo ${code} >> /etc/environment",
    unless => "grep ^${code}$ /etc/environment",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
}
