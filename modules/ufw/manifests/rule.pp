define ufw::rule(
  $app_or_port = $title,
  $allow = true,
  $from = 'any',
  $to = 'any',
  $protocol = undef
) {

  include 'ufw'

  $verb_allow = $allow? { false => 'deny', default => 'allow' }
  $proto = $protocol ? { undef => '', default => "proto ${protocol}" }

  $is_port = (is_integer($app_or_port) or ($app_or_port =~ /[,|:]/))
  $target = $is_port ? { true => "port ${$app_or_port}", default => "app ${app_or_port}" }

  $proto_unless = $protocol ? { undef => '', default => "/${protocol}" }
  $to_unless = $to ? { 'any' => $app_or_port, default => "${to} ${app_or_port}${proto_unless}" }
  $from_unless = $from ? { 'any' => 'Anywhere', default => $from }

  $ufw_unless = "ufw status | grep -iqE '^${to_unless}+.+${verb_allow}+.+${from_unless}'"

  exec { "[${title}] Set ${target} allow to ${allow} from ${from} to ${to}":
    provider => shell,
    command  => "ufw ${verb_allow} ${proto} from ${from} to ${to} ${target}",
    unless   => $ufw_unless,
    path     => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user     => 'root',
    require  => Package['ufw'],
  }
}
