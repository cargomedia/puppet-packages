class cm_janus::service {

  service { 'cm-janus':
    enable  => true,
    require => Package['cm-janus'],
  }
}
