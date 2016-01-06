define ufw::rule(
  $app_or_port = $title,
  $allow = true,
) {

  include 'ufw'

  $verb_allow = $allow? {
    false   => 'deny',
    default => 'allow',
  }

  exec { "Set ${app_or_port} allow to ${allow}":
    provider => shell,
    command  => "ufw ${verb_allow} ${app_or_port}",
    unless   => "ufw status | grep -iqE '^${app_or_port}+.+${verb_allow}'",
    path     => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user     => 'root',
    require  => Package['ufw'],
  }
}
