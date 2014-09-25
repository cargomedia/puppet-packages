define logrotate::entry (
  $file_paths = [],
  $commands = [],
  $content = undef,
) {

  require 'logrotate'

  $file_content = $content ? {
    undef => template("${module_name}/entry"),
    default => $content
  }

  file { "/etc/logrotate.d/${title}":
    ensure => file,
    content => $file_content,
    owner => '0',
    group => '0',
    mode => '0644',
  }
}
