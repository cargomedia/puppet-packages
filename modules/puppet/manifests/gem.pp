define puppet::gem {

  include 'puppet::common'

  package { "${title} (puppet)":
    name  => $title,
    ensure   => present,
    provider => puppet_gem,
    require  => Package['puppet-agent'],
  }

}
