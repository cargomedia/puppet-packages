define janus::plugin {

  include 'janus::version'
  include 'janus::service'

  janus::deps::plugin::install { $name:
    notify  => Service['janus'],
    janus_version => $janus::version::number,
  }

}
