define fluentd::config (
  $content,
  $priority = 50,
) {

  include 'fluentd'

  file { "/etc/fluentd/config.d/${priority}-${title}.conf":
    ensure  => file,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    content => $content,
    notify  => Daemon['fluentd'],
  }

}
