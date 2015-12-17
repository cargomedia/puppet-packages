define janus::plugin {

  require 'apt'
  include 'janus::service'
  include 'janus'

  package { "janus-gateway-${title}":
    provider => 'apt',
  }
}
