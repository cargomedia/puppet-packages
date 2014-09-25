define logrotate::entry (
  $file_patterns = [],
  $commands = []
) {

  require 'logrotate'

  file { "/etc/logrotate.d/${title}":
    ensure => file,
    content => template("${module_name}/entry"),
    owner => '0',
    group => '0',
    mode => '0644',
  }
}
