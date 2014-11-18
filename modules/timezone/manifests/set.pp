define timezone::set() {

  require 'timezone'

  exec{"Change time zone to ${title}":
    command => "echo '${title}' > /etc/timezone",
    unless => "grep ^${title}$ /etc/timezone",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],

  }
}
