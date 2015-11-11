define janus::plugin {

  include 'janus::service'

  janus::deps::plugin::install { $name:
    notify  => Service['janus'],
  }

}
