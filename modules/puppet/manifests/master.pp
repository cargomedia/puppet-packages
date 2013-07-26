#master.pp
class puppet::master ($certname = '') {

require 'puppet::common'

file {'/etc/puppet/manifests/site.pp':
  ensure    => present,
  content   => template('puppet/site.pp'),
  group     => 0,
  owner     => 0,
  mode      => '0644',
}

file {'/etc/puppet/hiera.yaml':
  ensure    => present,
  content   => template('puppet/hiera.yaml'),
  group     => 0,
  owner     => 0,
  mode      => '0644',
}

package {'puppetmaster':
  ensure  => present,
  require => [
  File['/etc/puppet/manifests/site.pp'],
  File['/etc/puppet/hiera.yaml']
  ],
}
}
