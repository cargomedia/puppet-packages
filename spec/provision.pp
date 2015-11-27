node default {

  require 'puppet::common'

  exec { 'apt update':
    provider    => shell,
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    command     => 'apt-get update',
    logoutput   => 'on_failure',
  }
  ->

  class { 'polipo':
    diskCacheRoot => '/tmp/proxy-cache',
    idleTime      => 0,
  }

# Workaround for stdlib-dependency of certain modules (see Puppetfiles)
  exec { 'puppet module install puppetlabs/stdlib':
    unless   => 'puppet module list | grep puppetlabs-stdlib',
    provider => shell,
  }
}
