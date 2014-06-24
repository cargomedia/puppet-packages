node default {

  require 'puppet::common'
  require 'apt::update'

  class {'polipo':
    diskCacheRoot => '/tmp/proxy-cache',
    idleTime => 0,
  }

  # Workaround for stdlib-dependency of certain modules (see Puppetfiles)
  exec {'puppet module install puppetlabs/stdlib':
    unless => 'puppet module list | grep puppetlabs-stdlib',
    provider => shell,
  }
}
