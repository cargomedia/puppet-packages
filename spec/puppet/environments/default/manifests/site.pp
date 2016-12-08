node default {

  require 'puppet::common'

  class { 'polipo':
    diskCacheRoot => '/tmp/proxy-cache',
    idleTime      => 0,
    require       => Exec['puppet module install puppetlabs/stdlib'],
  }
  # Workaround for stdlib-dependency of certain modules (see Puppetfiles)
  exec { 'puppet module install puppetlabs/stdlib':
    unless   => 'puppet module list | grep puppetlabs-stdlib',
    provider => shell,
  }
}
