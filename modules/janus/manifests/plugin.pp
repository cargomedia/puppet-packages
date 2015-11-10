define janus::plugin {

  require 'janus'
  include 'janus::service'

  if $name =~ /^[audioroom|rtpbroadcast]$/ {

    class { "janus::deps::plugin::${name}":
      notify  => Service['janus'],
    }

  }
}
