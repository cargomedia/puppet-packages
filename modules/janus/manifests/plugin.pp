define janus::plugin {

  include 'janus::service'

  if $name =~ /^[audioroom|rtpbroadcast]$/ {

    janus::deps::plugin::lib { $name:
      notify  => Service['janus'],
    }

  }
}
