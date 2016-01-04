define lightdm::config (
  $content
) {

  include 'lightdm'

  file { "/etc/lightdm/lightdm.conf.d/${title}.conf":
    ensure  => file,
    content => $content,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['lightdm'],
  }

}
