define janus::plugin {

  include 'janus::service'

  if $name =~ /^[audioroom|rtpbroadcast]$/ {

    janus::deps::plugin::install { $name:
      notify  => Service['janus'],
    }

  }
}
