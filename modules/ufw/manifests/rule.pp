define ufw::rule(
  $app_or_port = $title,
  $allow = true,
  $from = 'any',
  $to = 'any',
  $protocol = undef
) {

  include 'ufw'

  $verb_allow = $allow? {
    false   => 'deny',
    default => 'allow',
  }

  $proto = $protocol ? {
    undef   => '',
    default => "proto ${$proto}",
  }

  $is_port = ((count(split($app_or_port, ',')) > 1) or is_integer($app_or_port))
  $target = $is_port ? {
    true => "port ${$app_or_port}",
    default => "app ${app_or_port}",
  }

  exec { "Set ${target} allow to ${allow} from ${from} to ${to}":
    provider => shell,
    command  => "ufw ${verb_allow} ${proto} from ${from} to ${to} ${target}",
    unless   => "ufw status | grep -iqE '^${app_or_port}+.+${verb_allow}'",
    path     => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user     => 'root',
    require  => Package['ufw'],
  }
}
