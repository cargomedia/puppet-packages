define logrotate::entry ($content)
{
  require 'logrotate'

  file { "/etc/logrotate.d/${title}":
    ensure  => file,
    content => $content,
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }
}
