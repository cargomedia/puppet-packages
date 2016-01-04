node default {
  exec { '/bin/echo -n "" > /var/log/syslog': }
  ->
  exec { '/usr/bin/logger my-test': }
}
